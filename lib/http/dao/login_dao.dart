import 'package:flutter_bilibili/http/core/hinet.dart';
import 'package:flutter_bilibili/http/request/baserequest.dart';
import 'package:flutter_bilibili/http/request/login_request.dart';
import 'package:flutter_bilibili/http/request/registration_request.dart';

class LoginDao{

  static login(String userName,String passWord) {
    return _send(userName, passWord);
  }

  static registration(String userName,String passWord,String imoocId,String orderId) {
    return _send(userName, passWord,imoocId: imoocId,orderId:orderId);
  }

  static _send(String userName,String passWord,{String? imoocId,String? orderId}) async {
      BaseRequest request;
      if(imoocId != null && orderId != null){
        request = RegistrationRequest();
      }else{
        request = LoginRequest();
      }
      request.add("userName", userName)
          .add("password", passWord)
          .add("imoocId", imoocId ?? "")
          .add("orderId", orderId ?? "");
      var result = await HiNet.getInstance().fire(request);
      return result;
  }
}