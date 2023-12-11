import 'package:gomart/Menu/purchaseOrderDetail/models/purchase_order_detail_model.dart';

abstract class PurchaseOrderListEvent{
  const PurchaseOrderListEvent();
}

class OrderListEvent extends PurchaseOrderListEvent{
  final List<PurchaseOrderDetailModel>? orderList;
  OrderListEvent({
    this.orderList
  });
}

class SumOrderTotalsEvent extends PurchaseOrderListEvent{
  final int totalQuantity;
  final double ieps;
  final double iva;
  final double subTotal;
  final double total;

  SumOrderTotalsEvent({
    this.totalQuantity = 0,
    this.ieps = 0.0,
    this.iva = 0.0,
    this.subTotal = 0.0,
    this.total = 0.0,
  });
}