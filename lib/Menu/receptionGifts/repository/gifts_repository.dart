import 'dart:convert';

import 'package:gomart/Menu/receptionGifts/models/product_provider_model.dart';

import '../../../Api/common_api.dart';
import '../../../Environments/environment.dart';
import '../../Login/models/error_messaje.dart';
import '../models/reception_gifts_model.dart';

class GiftsRepository {
  final _api = CommonApi();

  Future<List<ProductProviderModel>> getSupplierProducts(
      {required int providerId}) async {
    final urlApi =
        "${Environment().apiGomart}Products/getSupplierProducts/providerId/$providerId";
    final response = await _api.sendGet(urlApi);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<ProductProviderModel> data =
            jsonData.map((map) => ProductProviderModel.fromJson(map)).toList();
        //print("Data gifts ${data.map((e) => e.toJson())}");
        return data;
      } else if (response.statusCode == 500) {
        //Revisar como se recupera el mensaje de error como en el login
        throw ("Error con el servidor");
      } else if (response.statusCode == 204) {
        throw ("No existen datos");
      } else {
        throw ("${response.reasonPhrase}");
      }
  }

  Future<ErrorMessaje>saveGifts({required List<ReceptionGiftsModel> gifts}) async{
    final urlApi = "${Environment().apiGomart}Purchases/save/receptionDetailGifts";
    var body = jsonEncode(gifts);
    final response = await _api.sendPost(urlApi,body);
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
  }
}
