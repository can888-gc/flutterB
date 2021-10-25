import 'package:flutter/scheduler.dart';
import 'package:flutter_bilibili/http/core/adapter/hiadapter.dart';
import 'package:flutter_bilibili/http/core/hierror.dart';
import 'package:flutter_bilibili/http/core/adapter/mockadapter.dart';
import 'package:flutter_bilibili/http/request/baserequest.dart';

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
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      error = e;
      printLog(e);
    }
    if (response == null) {
      printLog(error);
    }
    var result = response?.data;
    printLog(result);
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
    HiNetAdapter adapter = MockAdapter();

    printLog("请求的Uri==>${request.url()}");
    printLog("请求方式==>${request.httpMethod()}");
    request.addHeader("token", "123");
    printLog("header==>${request.header}");
    return adapter.send(request);
  }

  void printLog(msg) {
    print('hi_net:${msg.toString()}');
  }
}
