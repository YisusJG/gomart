class ProductBarCodes {
  String? barcode;

  ProductBarCodes({this.barcode});

  factory ProductBarCodes.fromJson(Map<String, dynamic> map) {
    return ProductBarCodes(
        barcode: map['barcode'],
    );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['barcode'] = barcode;
    return data;
  }
}