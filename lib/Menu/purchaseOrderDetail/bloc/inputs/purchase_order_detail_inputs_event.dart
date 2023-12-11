abstract class PurchaseOrderDetailInputsEvent {}

class InputProductCostEvent extends PurchaseOrderDetailInputsEvent{
  final int id;
  final double productCost;
  final int amountreceived;

  InputProductCostEvent({
    this.id = 0,
    this.productCost = 0.0,
    this.amountreceived = 0,
  });
}