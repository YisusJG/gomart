import '../../purchaseOrderDetail/models/ProductBarCodes.dart';

class ProductModel {
  int id;
  String name;
  String barcode;
  bool hasStock;
  String purchaseUnit;
  String validFrom;
  bool visible;
  String productCategory;
  String productSubcategory;
  String productStatus;
  int physicalInventory;
  List<ProductBarCodes>? productBarCodes;

  ProductModel({
        this.id = 0,
        this.name = "",
        this.barcode = "",
        this.hasStock = true,
        this.purchaseUnit = "",
        this.validFrom = "",
        this.visible = true,
        this.productCategory = "",
        this.productSubcategory = "",
        this.productStatus = "",
        this.physicalInventory = 0,
        this.productBarCodes,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      barcode: json['barcode'] ?? "",
      hasStock: json['hasStock'],
      purchaseUnit: json['purchaseUnit'],
      validFrom: json['validFrom'],
      visible: json['visible'],
      productCategory: json['productCategory'],
      productSubcategory: json['productSubcategory'],
      productStatus: json['productStatus'],
        productBarCodes: json['productBarCodes'] != null
            ? (json['productBarCodes'] as List).map((i) => ProductBarCodes.fromJson(i)).toList()
            : null
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['barcode'] = barcode;
    data['hasStock'] = hasStock;
    data['purchaseUnit'] = purchaseUnit;
    data['validFrom'] = validFrom;
    data['visible'] = visible;
    data['productCategory'] = productCategory;
    data['productSubcategory'] = productSubcategory;
    data['productStatus'] = productStatus;
    return data;
  }
}


