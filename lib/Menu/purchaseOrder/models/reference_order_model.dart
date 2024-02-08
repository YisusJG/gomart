class ReferenceOrderModel{
  final int orderId;
  final int branchId;
  final int typeDocumentId;
  final int providerId;
  final String? sapCode;
  final String providerReference;
  //final String typeDocument;

  ReferenceOrderModel({
    this.orderId = 0,
    this.branchId = 0,
    this.typeDocumentId = 0,
    this.providerId = 0,
    this.sapCode,
    this.providerReference = '',
    //this.typeDocument = ''
  });

}