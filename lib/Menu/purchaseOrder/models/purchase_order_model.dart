class PurchaseOrderModel {
  int id;
  int providerId;
  int branchId;
  String namePurchaseOrderType;
  String namePurchaseOrderStatus;
  String nameProvider;
  String purchaseOrderFolio;
  String insertDate;
  String estimatedDeliveryDate;
  String? sapCode;

  PurchaseOrderModel(
      {
        this.id = 0,
        this.providerId = 0,
        this.branchId = 0,
        this.namePurchaseOrderType ='',
        this.namePurchaseOrderStatus ='',
        this.nameProvider ='',
        this.purchaseOrderFolio ='',
        this.insertDate ='',
        this.estimatedDeliveryDate ='',
        this.sapCode,
      });

  factory PurchaseOrderModel.fromJson(Map<String, dynamic> map) {
    return PurchaseOrderModel(
    id: map['id'],
    providerId: map['providerId'],
    branchId: map['branchId'],
    namePurchaseOrderType: map['namePurchaseOrderType'],
    namePurchaseOrderStatus: map['namePurchaseOrderStatus'],
    nameProvider: map['nameProvider'],
    purchaseOrderFolio: map['purchaseOrderFolio'],
    insertDate: map['insertDate'],
    estimatedDeliveryDate: map['estimatedDeliveryDate'],
    sapCode: map['sapCode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['providerId'] = providerId;
    data['branchId'] = branchId;
    data['namePurchaseOrderType'] = namePurchaseOrderType;
    data['namePurchaseOrderStatus'] = namePurchaseOrderStatus;
    data['nameProvider'] = nameProvider;
    data['purchaseOrderFolio'] = purchaseOrderFolio;
    data['insertDate'] = insertDate;
    data['estimatedDeliveryDate'] = estimatedDeliveryDate;
    data['sapCode'] = sapCode;
    return data;
  }
}