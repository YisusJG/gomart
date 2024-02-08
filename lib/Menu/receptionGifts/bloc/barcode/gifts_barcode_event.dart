abstract class GiftsBarcodeEvent{}

class BarcodeGiftsEvent extends GiftsBarcodeEvent{
  final String barcode;

  BarcodeGiftsEvent({
    this.barcode = ''
  });
}