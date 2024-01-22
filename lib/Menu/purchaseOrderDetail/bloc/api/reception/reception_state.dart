import '../../../models/reception_obj.dart';

class ReceptionState{
  ReceptionObj? receptionObj;
  String errorApi;
  String message;
  ReceptionState({this.receptionObj, this.errorApi = "", this.message = ""});
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

