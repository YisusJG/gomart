abstract class InventoryBarcodeEvent{}

class BarcodeEvent extends InventoryBarcodeEvent{
  final String barcode;

  BarcodeEvent({
    this.barcode = ''
  });
}