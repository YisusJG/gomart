class ReceptionModel {
  int receptionTypeId;
  int receptionStatusId;
  int purchaseOrderId;
  double subtotal;
  double iva;
  double ieps;
  double discount;
  double total;
  int totalQuantity;
  String notes;
  int branchId;
  int timesPrinted;
  String sapCode;
  int insertUserId;
  String providerReference;
  int typeDocumentsReceptionId;
  int receptionIncidenceStatusId;
  String? cancellationReason;

  ReceptionModel(
      {
        this.receptionTypeId = 0,
        this.receptionStatusId = 0,
        this.purchaseOrderId = 0,
        this.subtotal = 0.0,
        this.iva = 0.0,
        this.ieps = 0.0,
        this.discount = 0.0,
        this.total = 0.0,
        this.totalQuantity = 0,
        this.notes = '',
        this.branchId = 0,
        this.timesPrinted = 0,
        this.sapCode  = '',
        this.insertUserId = 1,
        this.providerReference = '',
        this.typeDocumentsReceptionId = 1,
        this.receptionIncidenceStatusId = 0,
        this.cancellationReason,
      });

  factory ReceptionModel.fromJson(Map<String, dynamic> map) {
    return ReceptionModel(
        receptionTypeId: map['receptionTypeId'],
        receptionStatusId: map['receptionStatusId'],
        purchaseOrderId: map['purchaseOrderId'],
        subtotal: map['subtotal'],
        iva: map['iva'],
        ieps: map['ieps'],
        discount: map['discount'],
        total: map['total'],
        totalQuantity: map['totalQuantity'],
        notes: map['notes'],
        branchId: map['branchId'],
        timesPrinted: map['timesPrinted'],
        sapCode: map['sapCode'],
        insertUserId: map['insertUserId'],
        providerReference: map['providerReference'],
        typeDocumentsReceptionId: map['typeDocumentsReceptionId'],
        receptionIncidenceStatusId: map['receptionIncidenceStatusId'],
        cancellationReason: map['cancellationReason'],
    );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['receptionTypeId'] = receptionTypeId;
    data['receptionStatusId'] = receptionStatusId;
    data['purchaseOrderId'] = purchaseOrderId;
    data['subtotal'] = subtotal;
    data['iva'] = iva;
    data['ieps'] = ieps;
    data['discount'] = discount;
    data['total'] = total;
    data['totalQuantity'] = totalQuantity;
    data['notes'] = notes;
    data['branchId'] = branchId;
    data['timesPrinted'] = timesPrinted;
    data['sapCode'] = sapCode;
    data['insertUserId'] = insertUserId;
    data['providerReference'] = providerReference;
    data['typeDocumentsReceptionId'] = typeDocumentsReceptionId;
    data['receptionIncidenceStatusId'] = receptionIncidenceStatusId;
    data['cancellationReason'] = cancellationReason;
    return data;
  }
}
