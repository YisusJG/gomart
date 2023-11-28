class PurchaseOrderModel {
  int id;
  String namePurchaseOrderType;
  String namePurchaseOrderStatus;
  String nameProvider;
  String purchaseOrderFolio;
  String insertDate;
  String estimatedDeliveryDate;

  PurchaseOrderModel(
      {
        this.id = 0,
        this.namePurchaseOrderType ='',
        this.namePurchaseOrderStatus ='',
        this.nameProvider ='',
        this.purchaseOrderFolio ='',
        this.insertDate ='',
        this.estimatedDeliveryDate ='',
      });

  factory PurchaseOrderModel.fromJson(Map<String, dynamic> map) {
    return PurchaseOrderModel(
    id: map['id'],
    namePurchaseOrderType: map['namePurchaseOrderType'],
    namePurchaseOrderStatus: map['namePurchaseOrderStatus'],
    nameProvider: map['nameProvider'],
    purchaseOrderFolio: map['purchaseOrderFolio'],
    insertDate: map['insertDate'],
    estimatedDeliveryDate: map['estimatedDeliveryDate'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['namePurchaseOrderType'] = namePurchaseOrderType;
    data['namePurchaseOrderStatus'] = namePurchaseOrderStatus;
    data['nameProvider'] = nameProvider;
    data['purchaseOrderFolio'] = purchaseOrderFolio;
    data['insertDate'] = insertDate;
    data['estimatedDeliveryDate'] = estimatedDeliveryDate;
    return data;
  }
}