import 'dart:convert';
import 'package:gomart/Api/common_api.dart';
import 'package:gomart/Menu/inventory/model/branch_inventory_model.dart';
import 'package:gomart/Menu/inventory/model/product_category_model.dart';
import 'package:gomart/Menu/inventory/model/product_model.dart';
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
    }
    else {
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
      List<ProductModel> data = jsonData.map((map) => ProductModel.fromJson(map)).toList();
      print("Data getAllProductsByCategoryId ${data.length}");
      return data;
    }else if(response.statusCode == 500){
      throw ("Error con el servidor");
    }else if(response.statusCode == 204){
      throw ("No existen datos");
    }
    else {
      throw ("${response.reasonPhrase}");
    }
  }

  Future<BranchInventoryId> saveBranchInventory({required BranchInventoryModel branchInventoryModel}) async {
    final urlApi = "${Environment().apiGomart}Inventories/save/branchInventory";
    var body = jsonEncode(branchInventoryModel);
    final response = await _api.sendPost(urlApi,body);
    try {
      if (response.statusCode == 200){
        final data = BranchInventoryId.fromJson(json.decode(response.body));
        //print("DataApi $data");
        return data;
      }else if (response.statusCode == 500) {
        throw ("Error con el servidor");
      } else if (response.statusCode == 204) {
        throw ("No existen datos");
      } else {
        throw ("${response.reasonPhrase}");
      }
    }catch (e) {
      final data = ErrorMessaje.fromJson(json.decode(response.body));
      throw (data.messaje);
    }
  }
}