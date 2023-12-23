import 'package:gomart/Menu/purchaseOrder/models/purchase_order_model.dart';

class PurchaseOrderState{
  List<PurchaseOrderModel>? purchaseOrderModel;
  String errorApi;

  PurchaseOrderState({
    this.purchaseOrderModel,
    this.errorApi = "",
  });
}

class StartingPurchaseOrders extends PurchaseOrderState{
  StartingPurchaseOrders({required super.purchaseOrderModel});
}

class LoadPurchaseOrderState extends PurchaseOrderState{
  LoadPurchaseOrderState({required super.purchaseOrderModel});
}

class ErrorLoadingPurchaseOrder extends PurchaseOrderState{
  ErrorLoadingPurchaseOrder({required super.errorApi});
}