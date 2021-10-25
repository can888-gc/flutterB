import 'package:flutter_bilibili/http/request/baserequest.dart';

class TestRequest extends BaseRequest {

  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return "/uapi/test/test";
  }
}
