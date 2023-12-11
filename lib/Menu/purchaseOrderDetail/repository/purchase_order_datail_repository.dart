import 'dart:convert';

import '../../../Api/common_api.dart';
import '../../../Environments/environment.dart';
import '../models/purchase_order_detail_model.dart';

class PurchaseOrderDetailRepository{
  final _api = CommonApi();

  Future<List<PurchaseOrderDetailModel>>getPurchaseOrderDetail({required int purchaseOrderId})async{
    final urlApi = "${Environment().apiGomart}Purchases/getPurchasesOrderDetail/purchaseOrderId/$purchaseOrderId";
    //print("LLEga $urlApi");
    final response = await _api.sendGet(urlApi);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<PurchaseOrderDetailModel> data = jsonData.map((map) => PurchaseOrderDetailModel.fromJson(map)).toList();
      //print("Data orders ${data.map((e) => e.toJson())}");
      print("data ${data.length}");
      return data;
    }else if(response.statusCode == 500){   //Revisar como se recupera el mensaje de error como en el login
      throw ("Error con el servidor");
    }else if(response.statusCode == 204){
      throw ("No existen datos");
    }
    else {
      throw ("${response.reasonPhrase}");
    }
  }
}