import '../../models/reception_detail_model.dart';

class PurchaseOrderListState{
  final List<ReceptionDetailModel>? receptionDetail;  //separar el list de las otras variables
  final int totalQuantity;
  final double ieps;
  final double iva;
  final double subTotal;
  final double total;
  final double discount;


  PurchaseOrderListState({
    this.receptionDetail,
    this.totalQuantity = 0,
    this.ieps = 0,
    this.iva = 0,
    this.subTotal = 0,
    this.total = 0,
    this.discount = 0,
  });
}

class OrderListState extends PurchaseOrderListState{
  OrderListState({
    required super.receptionDetail
  });
}

class SumOrderTotalsState extends PurchaseOrderListState{
  SumOrderTotalsState({
    required super.totalQuantity,
    required super.ieps,
    required super.iva,
    required super.subTotal,
    required super.total,
    required super.discount
  });
}

