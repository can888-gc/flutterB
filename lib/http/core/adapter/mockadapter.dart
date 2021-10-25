import 'package:flutter_bilibili/http/core/adapter/hiadapter.dart';
import 'package:flutter_bilibili/http/request/baserequest.dart';

class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) {
    return Future.delayed(Duration(milliseconds: 1000), () {
      return HiNetResponse(
          data: {"code": 0, "message": "success"} as T, statusCode: 401);
    });
  }
}
