import '../../models/purchase_order_detail_model.dart';

class PurchaseOrderListState{
  final List<PurchaseOrderDetailModel>? orderList;  //separar el list de las otras variables
  final int totalQuantity;
  final double ieps;
  final double iva;
  final double subTotal;
  final double total;


  PurchaseOrderListState({
    this.orderList,
    this.totalQuantity = 0,
    this.ieps = 0,
    this.iva = 0,
    this.subTotal = 0,
    this.total = 0,
  });
}

class OrderListState extends PurchaseOrderListState{
  OrderListState({
    required super.orderList
  });
}

class SumOrderTotalsState extends PurchaseOrderListState{
  SumOrderTotalsState({
    required super.totalQuantity,
    required super.ieps,
    required super.iva,
    required super.subTotal,
    required super.total,
  });
}

