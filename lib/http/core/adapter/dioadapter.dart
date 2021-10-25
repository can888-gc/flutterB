
import 'package:dio/dio.dart';
import 'package:flutter_bilibili/http/core/adapter/hiadapter.dart';
import 'package:flutter_bilibili/http/core/hierror.dart';
import 'package:flutter_bilibili/http/request/baserequest.dart';

//添加对Dio的适配器
class DioAdapter extends HiNetAdapter{
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    var response,option = Options(headers: request.header);
    var error;
    try{
      if(request.httpMethod() == HttpMethod.GET){
        response = await Dio().get(request.url(),options: option);
      }else if(request.httpMethod() == HttpMethod.POST){
        response = await Dio().post(request.url(),options: option,data: request.params);
      }else if(request.httpMethod() == HttpMethod.DELETE){
        response = await Dio().delete(request.url(),options: option,data: request.params);
      }
    }on DioError catch(e){
      error = e;
      response = e.response;
    }
    if(error != null){
      throw HiNetError(response?.statusCode ?? -1, response?.statusMessage);
    }

    return Future.value(response);
  }

}