abstract class InventoryBarcodeState {
  String barcode;
  InventoryBarcodeState({
    this.barcode = ''
});
}

class BarcodeState extends InventoryBarcodeState{
  BarcodeState({
    required super.barcode
  });
}