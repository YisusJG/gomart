import 'package:http/http.dart';
import 'package:http/io_client.dart';

class CommonApi {
  static final CommonApi _api = CommonApi._internal();
  final _timeoutDuration = const Duration(seconds: 20);
  String? _token;

  findToken() async{
    //var db = await DB.instance.database;
    _token = null;
    return _token;
  }

  factory CommonApi() {
    return _api;
  }

  CommonApi._internal();

  Future<Response> sendPost(String route, [dynamic body]) async {
    await findToken();
    final http = IOClient();
    final url = Uri.parse(route);
    try {
      if (_token != null) {
        final response = await http
            .post(url,
            headers: {
              'Authorization': 'Bearer $_token',
              'Content-Type': 'application/json'
            },
            body: body)
            .timeout(_timeoutDuration,
            onTimeout: () => Response("Error timeout", 500));
        //Loggers.showDebug(response.body);
        return response;
      } else {
        final response = await http.post(url,
            headers: {'Content-Type': 'application/json'}, body: body);
        //Loggers.showDebug(response.body);
        return response;
      }
    } catch (e) {
      return Response(e.toString(), 500);
    }
  }

  Future<Response> sendGet(String route) async {

    await findToken();
    final http = IOClient();
    final url = Uri.parse(route);
    //print("Url: $url");
    try {
      if (_token != null) {
        final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json'
          },
        ).timeout(_timeoutDuration,
            onTimeout: () => Response("Error timeout", 500));
        //Loggers.showDebug(response.body);
        return response;
      } else {
        final response = await http.get(url, headers: {'Content-Type': 'application/json'});
        return response;
      }
    } catch (e) {
      return Response(e.toString(), 500);
    }
  }

}