abstract class OrderBarcodeEvent{}

class BarcodeEvent extends OrderBarcodeEvent{
  final String barcode;

  BarcodeEvent({
    this.barcode = ''
  });
}