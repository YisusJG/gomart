import 'dart:convert';

import 'package:gomart/Menu/receptionGifts/models/product_provider_model.dart';

import '../../../Api/common_api.dart';
import '../../../Environments/environment.dart';

class GiftsRepository{
  final _api = CommonApi();

  Future<List<ProductProviderModel>>getSupplierProducts({required int providerId})async{
    final urlApi = "${Environment().apiGomart}Products/getSupplierProducts/providerId/$providerId";
    //print("url $urlApi");
    final response = await _api.sendGet(urlApi);
    //print("status ${response.statusCode}");
    if (response.statusCode == 200) {
      //print("list ${response.body}");
      final List<dynamic> jsonData = json.decode(response.body);
      print("listBody ${jsonData.length}");
      List<ProductProviderModel> data = jsonData.map((map) => ProductProviderModel.fromJson(map)).toList();
      print("Data gifts ${data.map((e) => e.toJson())}");
      //print("data ${data.length}");
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