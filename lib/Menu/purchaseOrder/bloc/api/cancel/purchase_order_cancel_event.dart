import '../../../../purchaseOrderDetail/models/reception_model.dart';

class PurchaseOrderCancelEvent{}

class CancelReceptionEvent extends PurchaseOrderCancelEvent{
  final ReceptionModel receptionModel;

  CancelReceptionEvent({required this.receptionModel});
}