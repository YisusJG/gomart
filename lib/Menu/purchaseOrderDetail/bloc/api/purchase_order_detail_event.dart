abstract class PurchaseOrderDetailEvent{}

class LoadOrderDetailEvent extends PurchaseOrderDetailEvent{
  final int purchaseOrderId;
  final int providerId;
  LoadOrderDetailEvent({this.purchaseOrderId = 0, this.providerId = 0});
}