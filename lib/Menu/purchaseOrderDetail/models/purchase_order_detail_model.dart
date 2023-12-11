class PurchaseOrderDetailModel {
  int id;
  int purchaseOrderId;
  int quantity;
  int amountReceived;
  double unitPrice;
  double unitCost;
  String? name;
  String? barcode;
  String? description;
  double ieps;
  double iva;
  double subTotalGlobal;

  PurchaseOrderDetailModel(
      {
        this.id = 0,
        this.purchaseOrderId = 0,
        this.quantity = 0,
        this.amountReceived = 0,
        this.unitPrice = 0.0,
        this.unitCost = 0.0,
        this.name,
        this.barcode,
        this.description,
        this.ieps = 0.0,
        this.iva = 0.0,
        this.subTotalGlobal = 0.0
      });

  factory PurchaseOrderDetailModel.fromJson(Map<String, dynamic> json) {
    return PurchaseOrderDetailModel(
      id: json['id'],
      purchaseOrderId: json['purchaseOrderId'],
      quantity: json['quantity'],
      amountReceived: json['amountReceived'],
      unitPrice: json['unitPrice'],
      unitCost: json['unitCost'],
      name: json['name'],
      barcode: json['barcode'],
      description: json['description'],
      ieps: json['ieps'],
      iva: json['iva'],
      subTotalGlobal: json['subTotalGlobal'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['purchaseOrderId'] = purchaseOrderId;
    data['quantity'] = quantity;
    data['amountReceived'] = amountReceived;
    data['unitPrice'] = unitPrice;
    data['unitCost'] = unitCost;
    data['name'] = name;
    data['barcode'] = barcode;
    data['description'] = description;
    data['ieps'] = ieps;
    data['iva'] = iva;
    data['subTotalGlobal'] = subTotalGlobal;
    return data;
  }
}
