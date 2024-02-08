import '../../../models/type_document_reception_model.dart';

class CatTypeDocumentReceptionState{
  List<TypeDocumentReceptionModel>? typeDocument;
  String errorApi;

  CatTypeDocumentReceptionState({
    this.typeDocument  ,
    this.errorApi = "",
  });
}

class StartingDocumentReceptionState extends CatTypeDocumentReceptionState{
  StartingDocumentReceptionState({required super.typeDocument});
}

class LoadDocumentReceptionState extends CatTypeDocumentReceptionState{
  LoadDocumentReceptionState({required super.typeDocument});
}

class ErrorLoadingDocumentReceptionState extends CatTypeDocumentReceptionState{
  ErrorLoadingDocumentReceptionState({required super.errorApi});
}