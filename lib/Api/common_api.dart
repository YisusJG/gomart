import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:gomart/Menu/Login/models/error_messaje.dart';
import 'package:http/http.dart' as http;


class CommonApi {
  static final CommonApi _api = CommonApi._internal();
  final _timeoutDuration = const Duration(seconds: 5);
  String? _token;

  findToken() async{
    _token = null;
    return _token;
  }

  factory CommonApi() {
    return _api;
  }

  CommonApi._internal();

  Future<http.Response> sendPost(String route, [dynamic body]) async {
    await findToken();
    final url = Uri.parse(route);
    try {
      if (_token != null) {
        final response = await http.post(url, headers: {'Authorization': 'Bearer $_token', 'Content-Type': 'application/json'},
            body: body).timeout(_timeoutDuration,);
        try{
          ErrorMessaje messageApi = ErrorMessaje.fromJson(json.decode(response.body));
          return http.Response(messageApi.message,1010);
        }catch(e){
          e.toString();
        }
        return response;
      } else {
        final response = await http.post(url, headers: {'Content-Type': 'application/json'}, body: body).timeout(_timeoutDuration);
        try{
          //revisar esta parte , para los mensajes y manejar dos, uno de succes y otro de error
          ErrorMessaje messageApi = ErrorMessaje.fromJson(json.decode(response.body));
          if(messageApi.typeMessage == 1){
            return response;
          }else{
            return http.Response(messageApi.message,1010);
          }
        }catch(e){
          e.toString();
        }
        return response;
      }
    }on TimeoutException{
      return http.Response("No es posible obtener datos. Por favor conectate a una red de gomart", 1000);
    }on SocketException catch (e) {
      e.toString();
      return http.Response("En este momento no tienes internet", 1001);
    } catch(e){
      return http.Response(e.toString(), 500);
    }
  }

  Future<http.Response> sendGet(String route) async {

    await findToken();
    final url = Uri.parse(route);
    try {
      if (_token != null) {
        final response = await http.post(url, headers: {'Authorization': 'Bearer $_token', 'Content-Type': 'application/json'})
            .timeout(_timeoutDuration);
        try{
          ErrorMessaje messageApi = ErrorMessaje.fromJson(json.decode(response.body));
          return http.Response(messageApi.message,1010);
        }catch(e){
          e.toString();
        }
        return response;
      } else {
        final response = await http.get(url, headers: {'Content-Type': 'application/json'}).timeout(_timeoutDuration);
        try{
          ErrorMessaje messageApi = ErrorMessaje.fromJson(json.decode(response.body));
          return http.Response(messageApi.message,1010);
        }catch(e){
          e.toString();
        }
        return response;
      }
    }on TimeoutException{
      return http.Response("No es posible obtener datos. Por favor conectate a una red de gomart", 1000);
    }on SocketException catch (e) {
      e.toString();
      return http.Response("En este momento no tienes internet", 1001);
    } on HttpException catch (e) {
      return http.Response(e.toString(), 1002);
    } catch(e){
      return http.Response(e.toString(), 500);
    }
  }

}