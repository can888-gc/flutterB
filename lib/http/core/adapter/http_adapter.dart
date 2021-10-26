import 'dart:convert';

import 'package:flutter_bilibili/http/core/adapter/hiadapter.dart';
import 'package:flutter_bilibili/http/core/hierror.dart';
import 'package:flutter_bilibili/http/request/baserequest.dart';
import 'package:http/http.dart' as http;

class HttpAdapter extends HiNetAdapter{
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    var response,error;
    var url = Uri.parse(request.url());

    try{
      if(request.httpMethod() == HttpMethod.GET){
        response = await http.get(url,headers: request.header);
      }else if(request.httpMethod() == HttpMethod.POST){
        response = await http.post(url,headers: request.header,body: request.params);
      }else if(request.httpMethod() == HttpMethod.DELETE){
        response = await http.delete(url,headers: request.header,body: request.params);
      }
    } catch(e){
      error = e;
      response = e.toString();
    }

    var code = response.statusCode;

    if(code != 200){
      throw HiNetError(code, jsonDecode(response.body)['message']);
    }

    return _buildRes(response,request);
  }

  Future<HiNetResponse<T>> _buildRes<T>(http.Response response,BaseRequest request){
    return Future.value(
      HiNetResponse(
        statusCode: response.statusCode,
        statusMessage: jsonDecode(response.body)['message'],
        data: response.body as T,
      )
    );
  }

}