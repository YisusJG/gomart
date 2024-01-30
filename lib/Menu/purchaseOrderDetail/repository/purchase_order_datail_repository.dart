import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gomart/Menu/purchaseOrderDetail/models/reception_obj.dart';

import '../../../Api/common_api.dart';
import '../../../Environments/environment.dart';
import '../../Login/models/error_messaje.dart';
import '../models/purchase_order_detail_model.dart';
import '../models/reception_detail_model.dart';
import '../models/reception_model.dart';

class PurchaseOrderDetailRepository{
  final _api = CommonApi();

  Future<List<PurchaseOrderDetailModel>>getPurchaseOrderDetail({required int purchaseOrderId})async{
    final urlApi = "${Environment().apiGomart}Purchases/getPurchasesOrderDetail/purchaseOrderId/$purchaseOrderId"; //30076     6767
    final response = await _api.sendGet(urlApi);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      print("Data orders $jsonData");
      List<PurchaseOrderDetailModel> data = jsonData.map((map) => PurchaseOrderDetailModel.fromJson(map)).toList();
      print("respuesta api ${data.first.productBarCodes?.map((e) => e.barcode)}");
      return data;
    }else if(response.statusCode == 500){
      throw ("Error con el servidor");
    }else if(response.statusCode == 204){
      throw ("No existen datos");
    }else if(response.statusCode == 1000){
      throw (response.body);
    }else if(response.statusCode == 1001){
      throw (response.body);
    }else if(response.statusCode == 1010){
      throw (response.body);
    }
    else {
      throw ("${response.reasonPhrase}");
    }
  }

  Future<ReceptionObj> saveReception({required ReceptionModel receptionModel}) async{
    final urlApi = "${Environment().apiGomart}Purchases/save/reception";
    var body = jsonEncode(receptionModel);
    final response = await _api.sendPost(urlApi,body);
      if (response.statusCode == 200){
        final dynamic jsonData = jsonDecode(response.body);
        ReceptionObj data = ReceptionObj.fromJson(jsonData);
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

  Future<ErrorMessaje>saveReceptionDetails({required List<ReceptionDetailModel> receptionDetail}) async{
    final urlApi = "${Environment().apiGomart}Purchases/save/receptionDetails";
    var body = jsonEncode(receptionDetail);
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

}