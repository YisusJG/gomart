
class PurchaseOrderDetailInputsState{
  int id;
  double productCost;
  int amountReceived;
  String note;
  double subtotal;
  double discount;
  String inserDate;
  double total;
  bool isReceived;

  PurchaseOrderDetailInputsState({
    this.id = 0,
    this.productCost = 0.0,
    this.amountReceived = 0,
    this.note = "",
    this.subtotal = 0.0,
    this.discount = 0.0,
    this.inserDate = "",
    this.total = 0.0,
    this.isReceived = false,
  });

}

class InputProductCostState extends PurchaseOrderDetailInputsState{
  InputProductCostState({
    required super.id,
    required super.productCost,
    required super.amountReceived,
    required super.note,
    required super.subtotal,
    required super.discount,
    required super.inserDate,
    required super.total,
    required super.isReceived
  });
}