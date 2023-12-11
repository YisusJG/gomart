import '../../models/purchase_order_detail_model.dart';

abstract class PurchaseOrderDetailState{
  List<PurchaseOrderDetailModel>? purchaseOrderDetailModel;
  String errorApi;

  PurchaseOrderDetailState({
    this.purchaseOrderDetailModel,
    this.errorApi = ""
  });
}

class StartingPurchaseOrderDetail extends PurchaseOrderDetailState{
  StartingPurchaseOrderDetail({required super.purchaseOrderDetailModel});
}

class LoadPurchaseOrderDetail extends PurchaseOrderDetailState{
  LoadPurchaseOrderDetail({required super.purchaseOrderDetailModel});
}

class ErrorPurchaseOrderDetail extends PurchaseOrderDetailState{
  ErrorPurchaseOrderDetail({required super.errorApi});
}