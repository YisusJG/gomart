abstract class GiftsBarcodeState{
  String barcode;
  GiftsBarcodeState({
    this.barcode = ''
  });
}

class BarcodeGiftsState extends GiftsBarcodeState{
  BarcodeGiftsState({
    required super.barcode
  });
}
