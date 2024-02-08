import 'package:gomart/Menu/receptionGifts/models/reception_gifts_model.dart';


class SupplierProductsState{
  List<ReceptionGiftsModel>? lsReceptionGifts;
  String errorApi;

  SupplierProductsState({
    this.lsReceptionGifts,
    this.errorApi = ""
  });
}

class StartingSupplierProductsState extends SupplierProductsState{
  StartingSupplierProductsState({required super.lsReceptionGifts});
}

class LoadSupplierProductsState extends SupplierProductsState{
  LoadSupplierProductsState({required super.lsReceptionGifts});
}

class ErrorSupplierProductsState extends SupplierProductsState{
  ErrorSupplierProductsState({required super.errorApi});
}