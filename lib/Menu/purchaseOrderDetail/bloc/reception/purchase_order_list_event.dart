import '../../models/reception_detail_model.dart';

class PurchaseOrderListEvent{  //cambiar orderlist por receptionList
  const PurchaseOrderListEvent();
}

class OrderListEvent extends PurchaseOrderListEvent{
  final List<ReceptionDetailModel>? receptionDetail;
  OrderListEvent({
    this.receptionDetail
  });
}

class SumOrderTotalsEvent extends PurchaseOrderListEvent{
  final int totalQuantity;
  final double ieps;
  final double iva;
  final double subTotal;
  final double total;
  final double discount;

  SumOrderTotalsEvent({
    this.totalQuantity = 0,
    this.ieps = 0.0,
    this.iva = 0.0,
    this.subTotal = 0.0,
    this.total = 0.0,
    this.discount = 0.0
  });
}

