import 'package:flutter_bilibili/http/request/baserequest.dart';

class NoticeRequest extends BaseRequest{
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return true;
  }

  @override
  String path() {
    return "/uapi/notice";
  }

}