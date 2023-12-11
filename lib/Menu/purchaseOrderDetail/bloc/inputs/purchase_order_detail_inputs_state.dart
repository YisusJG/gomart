
abstract class PurchaseOrderDetailInputsState{
  int id;
  double productCost;
  int amountReceived;
  PurchaseOrderDetailInputsState({
    this.id = 0,
    this.productCost = 0.0,
    this.amountReceived = 0,
  });

}

class InputProductCostState extends PurchaseOrderDetailInputsState{
  InputProductCostState({
    required super.id,
    required super.productCost,
    required super.amountReceived,
  });
}