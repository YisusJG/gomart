import '../../../models/reception_obj.dart';

class ReceptionState{
  ReceptionObj? receptionObj;
  String errorApi;
  String message;
  String messagePurchaseOrder;

  ReceptionState({this.receptionObj, this.errorApi = "", this.message = "", this.messagePurchaseOrder = ""});
}

class SaveReceptionState extends ReceptionState{
  SaveReceptionState({required super.receptionObj});
}

class ErrorSaveReception extends ReceptionState{
  ErrorSaveReception({required super.errorApi});
}

class SaveReceptionDetailsState extends ReceptionState{
  SaveReceptionDetailsState({required super.message});
}

class ErrorSaveReceptionDetails extends ReceptionState{
  ErrorSaveReceptionDetails({required super.errorApi});
}

class UpdateIsBusyState extends ReceptionState{
  UpdateIsBusyState({required super.messagePurchaseOrder});
}

