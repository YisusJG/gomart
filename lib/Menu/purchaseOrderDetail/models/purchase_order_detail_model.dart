class PurchaseOrderDetailModel {
  int id;
  int purchaseOrderId;
  int productId;
  int unitId;
  int quantity;
  int amountReceived;
  double unitPrice;
  double unitCost;
  String name;
  String? barcode;
  String? description;
  double ieps;
  double iva;
  double roundingValue;
  int expiration;

  PurchaseOrderDetailModel(
      {
        this.id = 0,
        this.purchaseOrderId = 0,
        this.productId = 0,
        this.unitId = 0,
        this.quantity = 0,
        this.amountReceived = 0,
        this.unitPrice = 0.0,
        this.unitCost = 0.0,
        this.name="",
        this.barcode,
        this.description,
        this.ieps = 0.0,
        this.iva = 0.0,
        this.roundingValue = 0.0,
        this.expiration = 0,
      });

  factory PurchaseOrderDetailModel.fromJson(Map<String, dynamic> json) {
    return PurchaseOrderDetailModel(
      id: json['id'],
      purchaseOrderId: json['purchaseOrderId'],
      productId: json['productId'],
      unitId: json['unitId'],
      quantity: json['quantity'],
      amountReceived: json['amountReceived'],
      unitPrice: json['unitPrice'],
      unitCost: json['unitCost'],
      name: json['name'],
      barcode: json['barcode'],
      description: json['description'],
      ieps: json['ieps'],
      iva: json['iva'],
      roundingValue: json['roundingValue'],
      expiration: json['expiration'],
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['purchaseOrderId'] = purchaseOrderId;
    data['productId'] = productId;
    data['unitId'] = unitId;
    data['quantity'] = quantity;
    data['amountReceived'] = amountReceived;
    data['unitPrice'] = unitPrice;
    data['unitCost'] = unitCost;
    data['name'] = name;
    data['barcode'] = barcode;
    data['description'] = description;
    data['ieps'] = ieps;
    data['iva'] = iva;
    data['roundingValue'] = roundingValue;
    data['expiration'] = expiration;
    return data;
  }

}
