import '../../purchaseOrderDetail/models/ProductBarCodes.dart';

class ProductProviderModel {
  int productId;
  String name;
  String barcode;
  String sapmaterial;
  String nameUnit;
  int quantity;
  double roundingValue;
  int unitId;
  List<ProductBarCodes>? productBarCodes;

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
        this.productBarCodes
      });

  factory ProductProviderModel.fromJson(Map<String, dynamic> json) {
    return ProductProviderModel(
    productId: json['productId'],
    name: json['name'],
    barcode: json['barcode'],
    sapmaterial: json['sapmaterial'],
    nameUnit: json['nameUnit'],
    quantity: json['quantity'],
    roundingValue: json['roundingValue'],
    unitId: json['unitId'],
    productBarCodes: json['productBarCodes'] != null
        ? (json['productBarCodes'] as List).map((i) => ProductBarCodes.fromJson(i)).toList()
        : null
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