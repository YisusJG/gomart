import 'dart:convert';

import 'package:gomart/Environments/environment.dart';
import 'package:gomart/Login/models/employee_model.dart';

import '../../Api/common_api.dart';

class LoginRepository{
  final _api = CommonApi();

  Future<EmployeeModel> getUser({required String user, required String password}) async {
    final uriApi = "${Environment().apiGomart}Empleados/validaUsuario";
    var body = jsonEncode(<String, String>{
      'Email': user,
      'Password': password,
    });
    final response = await _api.sendPost(uriApi, body);
    if (response.statusCode == 200) {
      final data = EmployeeModel.fromJson(json.decode(response.body));
      return data;
    } else if(response.statusCode == 500){
      throw ("Usuario no registrado");
    }else if(response.statusCode == 204){
      throw ("No existen datos");
    }
    else {
      throw ("${response.reasonPhrase}");
    }
  }
}