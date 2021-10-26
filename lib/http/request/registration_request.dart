//注册的请求类
import 'package:flutter_bilibili/http/request/baserequest.dart';

class RegistrationRequest extends BaseRequest{
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return "/uapi/user/registration";
  }

}