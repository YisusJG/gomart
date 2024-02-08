import 'dart:convert';
import 'package:gomart/Api/common_api.dart';
import '../../../Environments/environment.dart';
import '../../Login/models/error_messaje.dart';
import '../../purchaseOrderDetail/models/reception_model.dart';
import '../models/purchase_order_model.dart';
import '../models/type_document_reception_model.dart';

class PurchaseOrderRepository{
  final _api = CommonApi();

  Future<List<PurchaseOrderModel>>getAllPurchaseOrders()async{

    final urlApi = "${Environment().apiGomart}Purchases/getAllPurchasesOrder";
    final response = await _api.sendGet(urlApi);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<PurchaseOrderModel> data = jsonData.map((map) => PurchaseOrderModel.fromJson(map)).toList();
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

  Future<List<TypeDocumentReceptionModel>>getAllTypeDocumentReceptions() async {

    final urlApi = "${Environment().apiGomart}TypeDocumentReception/getAllTypeDocumentReception";
    final response = await _api.sendGet(urlApi);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<TypeDocumentReceptionModel> data = jsonData.map((map) => TypeDocumentReceptionModel.fromJson(map)).toList();
      //print("Data orders ${data.map((e) => e.toJson())}");
      return data;
    }else if(response.statusCode == 500){
      throw ("Error con el servidor");
    } else {
      throw ("${response.reasonPhrase}");
    }
  }

  Future<ErrorMessaje>cancelReception({required ReceptionModel receptionModel}) async{
    final urlApi = "${Environment().apiGomart}Purchases/cancel/reception";
    var body = jsonEncode(receptionModel);
    final response = await _api.sendPost(urlApi,body);
    try {
      if (response.statusCode == 200){
        final data = ErrorMessaje.fromJson(json.decode(response.body));
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
      throw (data.message);
    }
  }
}