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
        this.physicalInventory = 0
  });

  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      barcode: map['barcode'],
      hasStock: map['hasStock'],
      purchaseUnit: map['purchaseUnit'],
      validFrom: map['validFrom'],
      visible: map['visible'],
      productCategory: map['productCategory'],
      productSubcategory: map['productSubcategory'],
      productStatus: map['productStatus'],
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


