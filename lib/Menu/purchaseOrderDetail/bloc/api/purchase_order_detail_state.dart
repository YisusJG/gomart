import '../../models/reception_detail_model.dart';

class PurchaseOrderDetailState{
  List<ReceptionDetailModel>? receptionDetail;
  String errorApi;

  PurchaseOrderDetailState({
    this.receptionDetail,
    this.errorApi = ""
  });
}

class StartingPurchaseOrderDetail extends PurchaseOrderDetailState{
  StartingPurchaseOrderDetail({required super.receptionDetail});
}

class LoadPurchaseOrderDetail extends PurchaseOrderDetailState{
  LoadPurchaseOrderDetail({required super.receptionDetail});
}

class ErrorPurchaseOrderDetail extends PurchaseOrderDetailState{
  ErrorPurchaseOrderDetail({required super.errorApi});
}