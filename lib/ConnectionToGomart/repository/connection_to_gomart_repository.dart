import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gomart/ConnectionToGomart/models/branch_model.dart';
import 'package:gomart/ConnectionToGomart/models/ip_gomart_modal.dart';
import 'package:gomart/DataBase/entities/ip_gomart_entity.dart';
import '../../Api/common_api.dart';
import '../../DataBase/db.dart';
import '../../Environments/environment.dart';

class ConnectionToGomartRepository{
  final _api = CommonApi();

  Future<BranchModel> getBranchGomart({required String ipGomart}) async {
    //final pruebaApi = Environment().apiGomart.replaceAll("prueba_ip", ipGomart);
    final urlApi = "${Environment().apiGomart}Branches/$ipGomart";
    //final urlApi = "${pruebaApi}Branches/$ipGomart";
    debugPrint(urlApi);
    final response = await _api.sendGet(urlApi);
    if (response.statusCode == 200) {
      final data = BranchModel.fromJson(json.decode(response.body));
      return data;
    }else if(response.statusCode == 500){
      throw ("No existe sucursal con esa IP");
    }else if(response.statusCode == 204){
      throw ("No existen datos");
    }else if(response.statusCode == 1000){
      throw (response.body);
    }else if(response.statusCode == 1001){
      throw (response.body);
    }
    else {
      throw ("${response.reasonPhrase}");
    }
  }

  Future<bool> saveIpGomart({required IpGomartModal ipGomartModal}) async{
    final db = await DB.instance.database;
    db?.ipGomartDao.insertIpGomart(IpGomartEntity.fromEntity(ipGomartModal));
    return true;
  }

}