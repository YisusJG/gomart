abstract class OrderBarcodeState{
  String barcode;
  OrderBarcodeState({
    this.barcode = ''
  });
}

class BarcodeState extends OrderBarcodeState{
  BarcodeState({
    required super.barcode
  });
}

