class ProductProviderModel {
  int productId;
  String name;
  String barcode;
  String sapmaterial;
  String nameUnit;
  int quantity;
  double roundingValue;
  int unitId;

  ProductProviderModel(
      {
        this.productId = 0,
        this.name = "",
        this.barcode = "",
        this.sapmaterial = "",
        this.nameUnit = "",
        this.quantity = 0,
        this.roundingValue = 0,
        this.unitId = 0,
      });

  factory ProductProviderModel.fromJson(Map<String, dynamic> map) {
    return ProductProviderModel(
    productId: map['productId'],
    name: map['name'],
    barcode: map['barcode'],
    sapmaterial: map['sapmaterial'],
    nameUnit: map['nameUnit'],
    quantity: map['quantity'],
    roundingValue: map['roundingValue'],
    unitId: map['unitId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['name'] = name;
    data['barcode'] = barcode;
    data['sapmaterial'] = sapmaterial;
    data['nameUnit'] = nameUnit;
    data['quantity'] = quantity;
    data['roundingValue'] = roundingValue;
    data['unitId'] = unitId;
    return data;
  }
}