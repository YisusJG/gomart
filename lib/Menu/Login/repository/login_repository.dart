import 'dart:convert';

import 'package:gomart/ConnectionToGomart/models/branch_model.dart';
import 'package:gomart/DataBase/entities/branch_entity.dart';
import 'package:gomart/DataBase/entities/employee_entity.dart';
import 'package:gomart/Environments/environment.dart';

import '../../../Api/common_api.dart';
import '../../../DataBase/db.dart';
import '../models/employee_model.dart';
import '../models/error_messaje.dart';

class LoginRepository{
  final _api = CommonApi();

  Future<EmployeeModel> getUser({required String user, required String password}) async {
      final uriApi = "${Environment().apiGomart}Empleados/validaUsario";
      var body = jsonEncode(<String, String>{
        'User': user,
        'Password': password,
      });
      final response = await _api.sendPost(uriApi, body);

      try {
      if (response.statusCode == 200) {
       // print("DataApi ${response.body}");
        final data = EmployeeModel.fromJson(json.decode(response.body));
       // print("DataApi $data");
        return data;
      } else if (response.statusCode == 500) {
        throw ("Usuario no registrado");
      } else if (response.statusCode == 204) {
        throw ("No existen datos");
      } else {
        throw ("${response.reasonPhrase}");
      }
      }catch (e){
        final data = ErrorMessaje.fromJson(json.decode(response.body));
        throw (data.messaje);
      }
  }

  Future<bool> saveEmployee({required EmployeeModel employeeModel}) async{
    final db = await DB.instance.database;
    db?.employeeDao.insertEmployee(EmployeeEntity.fromEntity(employeeModel));
    return true;
  }

  Future<bool> saveBranch({required BranchModel branchModel}) async{
    final db = await DB.instance.database;
    db?.branchDao.insertBranch(BranchEntity.fromEntity(branchModel));
    final onservar = await db?.branchDao.findAllBranch();
    print("datos branch ${onservar!.length}");
    return true;
  }

}