abstract class PurchaseOrderDetailInputsEvent {}

class InputProductCostEvent extends PurchaseOrderDetailInputsEvent{
  final int id;
  final double productCost;
  final int amountreceived;
  final String note;
  final double subTotal;
  final double discount;
  final String inserDate;
  final double total;
  final bool isReceived;

  InputProductCostEvent({
    this.id = 0,
    this.productCost = 0.0,
    this.amountreceived = 0,
    this.note = '',
    this.subTotal = 0.0,
    this.discount = 0.0,
    this.inserDate = "",
    this.total = 0.0,
    this.isReceived = false,
  });
}