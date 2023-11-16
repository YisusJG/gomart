import 'dart:convert';

import 'package:gomart/ConnectionToGomart/models/branch_model.dart';

import '../../Api/common_api.dart';
import '../../Environments/environment.dart';

class ConnectionToGomartRepository{
  final _api = CommonApi();

  Future<BranchModel> getBranchGomart({required String ipGomart}) async {
    final urlApi = "${Environment().API_GOMART}Branches/$ipGomart";
    final response = await _api.sendGet(urlApi);
    if (response.statusCode == 200) {
      final data = BranchModel.fromJson(json.decode(response.body));
      return data;
    }else if(response.statusCode == 500){
      throw ("No existe sucursal con esa IP");
    }else if(response.statusCode == 204){
      throw ("No existen datos");
    }
    else {
      throw ("${response.reasonPhrase}");
    }
  }
}