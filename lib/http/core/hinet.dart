import 'package:flutter/scheduler.dart';
import 'package:flutter_bilibili/http/core/adapter/dioadapter.dart';
import 'package:flutter_bilibili/http/core/adapter/hiadapter.dart';
import 'package:flutter_bilibili/http/core/hierror.dart';
import 'package:flutter_bilibili/http/core/adapter/mockadapter.dart';
import 'package:flutter_bilibili/http/request/baserequest.dart';

import 'adapter/http_adapter.dart';

class HiNet {
  HiNet._();
  static HiNet? _instance;
  static HiNet getInstance() {
    _instance ??= HiNet._();
    return _instance!;
  }

  Future fire(BaseRequest request) async {
    HiNetResponse? response;
    var error;
    try {
      printLog("目标-->${request.url()}");
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      error = e;
      printLog(e);
    }

    var result = response?.data;
    printLog("结果-->${result}");
    var status = response?.statusCode;
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw HiNetError(status ?? -1, result.toString(), data: result);
    }
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    HiNetAdapter adapter = DioAdapter();
    // HiNetAdapter adapter = HttpAdapter();
    return adapter.send(request);
  }

  void printLog(msg) {
    print('hi_net:${msg.toString()}');
  }
}
