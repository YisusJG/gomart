class PurchaseOrderCancelState{
  String errorApi;
  String message;

  PurchaseOrderCancelState({
    this.errorApi ="",
    this.message = "",
  });
}


class CancelReceptionState extends PurchaseOrderCancelState{
  CancelReceptionState({required super.message});
}

class ErrorCancelReception extends PurchaseOrderCancelState{
  ErrorCancelReception({required super.errorApi});
}