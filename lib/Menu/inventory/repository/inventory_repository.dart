import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gomart/Api/common_api.dart';
import 'package:gomart/ConnectionToGomart/models/branch_model.dart';
import 'package:gomart/Menu/Login/models/employee_model.dart';
import 'package:gomart/Menu/inventory/model/branch_inventory_model.dart';
import 'package:gomart/Menu/inventory/model/branch_inventory_product_model.dart';
import 'package:gomart/Menu/inventory/model/product_category_model.dart';
import 'package:gomart/Menu/inventory/model/product_model.dart';
import '../../../DataBase/db.dart';
import '../../../DataBase/entities/branch_entity.dart';
import '../../../DataBase/entities/employee_entity.dart';
import '../../../Environments/environment.dart';
import '../../Login/models/error_messaje.dart';
import '../model/branch_inventory_id.dart';

class InventoryRepository{
  final _api = CommonApi();

  Future<List<ProductCategoryModel>> getProductCategories() async {
    final urlApi = "${Environment().apiGomart}ProductCategories/getAllProductCategories";
    final response = await _api.sendGet(urlApi);
    if(response.statusCode == 200){
      final List<dynamic> jsonData = jsonDecode(response.body);
      List<ProductCategoryModel> data = jsonData.map((map) => ProductCategoryModel.fromJson(map)).toList();
      return data;
    }else if(response.statusCode == 500){
      throw ("Error con el servidor");
    }else if(response.statusCode == 204){
      throw ("No existen datos");
    }else if(response.statusCode == 1000){
      throw (response.body);
    }else if(response.statusCode == 1001){
      throw (response.body);
    } else {
      throw ("${response.reasonPhrase}");
    }
  }

  Future<List<ProductModel>> getAllProductsByCategory() async {
    final urlApi = "${Environment().apiGomart}Products/getAllProducts";
    final response = await _api.sendGet(urlApi);
    if(response.statusCode == 200){
      final List<dynamic> jsonData = jsonDecode(response.body);
      List<ProductModel> data = jsonData.map((map) => ProductModel.fromJson(map)).toList();
      print("data ${data.length}");
      return data;
    }else if(response.statusCode == 500){
      throw ("Error con el servidor");
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

  Future<List<ProductModel>> getAllProductsByCategoryId({required int categoryId}) async {
    final urlApi = "${Environment().apiGomart}Products/getProductsByCategoryId/categoryId/$categoryId";
    print("urlApi $urlApi");
    final response = await _api.sendGet(urlApi);
    if(response.statusCode == 200){
      final List<dynamic> jsonData = jsonDecode(response.body);
      debugPrint("El json como respuesta es $jsonData");
      List<ProductModel> data = jsonData.map((map) => ProductModel.fromJson(map)).toList();
      print("Data getAllProductsByCategoryId ${data.length}");
      return data;
    }else if(response.statusCode == 500){
      throw ("Error con el servidor");
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

  Future<BranchInventoryId> saveBranchInventory({required BranchInventoryModel branchInventoryModel}) async {

    final urlApi = "${Environment().apiGomart}Inventories/save/branchInventory";
    var body = jsonEncode(branchInventoryModel);
    final response = await _api.sendPost(urlApi,body);

    if (response.statusCode == 200){
      final data = BranchInventoryId.fromJson(json.decode(response.body));
      return data;
    }else if (response.statusCode == 500) {
      throw ("Error con el servidor");
    } else if (response.statusCode == 204) {
      throw ("No existen datos");
    } else if(response.statusCode == 1000){
      throw (response.body);
    }else if(response.statusCode == 1001){
      throw (response.body);
    }
    else {
      throw ("${response.reasonPhrase}");
    }

  }

  Future<ErrorMessaje> saveBranchInventoryProduct({required List<BranchInventoryProductModel> branchInventoryProductModel}) async {
    final urlApi = "${Environment().apiGomart}Inventories/save/branchInventoryProduct";
    var body = jsonEncode(branchInventoryProductModel);
    final response = await _api.sendPost(urlApi,body);

    if (response.statusCode == 200){
      final data = ErrorMessaje.fromJson(json.decode(response.body));
      return data;
    }else if (response.statusCode == 500) {
      throw ("Error con el servidor");
    } else if (response.statusCode == 204) {
      throw ("No existen datos");
    } else if(response.statusCode == 1000){
      debugPrint(response.body);
      throw (response.body);
    }else if(response.statusCode == 1001){
      debugPrint(response.body);
      throw (response.body);
    }
    else {
      throw ("${response.reasonPhrase}");
    }
  }

  Future<EmployeeModel?> getEmployeeInventory() async{
    final db = await DB.instance.database;
    EmployeeEntity? employeeEntity = await db!.employeeDao.findEmployee();
    return EmployeeModel.fromJson(employeeEntity!.employeeEntityToMap());
  }

  Future<BranchModel?> getBranchInventory() async{
    final db = await DB.instance.database;
    BranchEntity? branchEntity = await db?.branchDao.findBranch();
    return BranchModel.fromJson(branchEntity!.branchEntityToMap());
  }

}