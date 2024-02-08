abstract class PurchaseOrderDetailEvent{}

class LoadOrderDetailEvent extends PurchaseOrderDetailEvent{
  final int purchaseOrderId;
  LoadOrderDetailEvent({this.purchaseOrderId = 0});
}