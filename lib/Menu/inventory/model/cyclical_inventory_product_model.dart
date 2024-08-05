import '../../purchaseOrderDetail/models/ProductBarCodes.dart';

class CyclicalInventoryProductModel {
  int id;
  int productId;
  String product;
  String barcode;
  int count;
  List<ProductBarCodes>? productBarCodes;

  CyclicalInventoryProductModel({
    required this.id,
    required this.productId,
    required this.product,
    required this.barcode,
    this.productBarCodes,
    this.count = 0
  });

  factory CyclicalInventoryProductModel.fromJson(Map<String, dynamic> json) {
    return CyclicalInventoryProductModel(
      id: json['id'] as int,
      productId: json['productId'] as int, // SE TIENE QUE CAMBIAR A INT
      product: json['product'] as String,
      barcode: json['barcode'] as String,
      productBarCodes: json['productBarCodes'] != null
          ? (json['productBarCodes'] as List).map((i) => ProductBarCodes.fromJson(i)).toList()
          : null
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productId'] = productId;
    data['product'] = product;
    data['barcode'] = barcode;
    if (productBarCodes!= null) {
      data['productBarCodes'] = productBarCodes?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}