import 'dart:async';
import 'dart:io';
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
        return response;
      } else {
        final response = await http.post(url, headers: {'Content-Type': 'application/json'}, body: body).timeout(_timeoutDuration);
        return response;
      }
    }on TimeoutException{
      return http.Response("No es posible obtener datos. Por favor conectate a una red de gomart", 1000);
    }on SocketException catch (e) {
      return http.Response("En este momento no tienes conexion", 1001);
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
        return response;
      } else {
        final response = await http.get(url, headers: {'Content-Type': 'application/json'}).timeout(_timeoutDuration);
        return response;
      }
    }on TimeoutException{
      return http.Response("No es posible obtener datos. Por favor conectate a una red de gomart", 1000);
    }on SocketException catch (e) {
      return http.Response("En este momento no tienes conexion", 1001);
    } on HttpException catch (e) {
      return http.Response(e.toString(), 1002);
    } catch(e){
      return http.Response(e.toString(), 500);
    }
  }

}