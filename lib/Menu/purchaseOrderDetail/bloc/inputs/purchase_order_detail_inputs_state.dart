
class PurchaseOrderDetailInputsState{
  int id;
  double productCost;
  int amountReceived;
  String note;
  PurchaseOrderDetailInputsState({
    this.id = 0,
    this.productCost = 0.0,
    this.amountReceived = 0,
    this.note = "",
  });

}

class InputProductCostState extends PurchaseOrderDetailInputsState{
  InputProductCostState({
    required super.id,
    required super.productCost,
    required super.amountReceived,
    required super.note,
  });
}