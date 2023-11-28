import 'package:flutter/services.dart';

class ScanBarcodeChannel{
  static const MethodChannel _channel = MethodChannel('barcode_channel');

  Future<void> prueba() async {
    try {
      await _channel.invokeMethod('prueba').whenComplete(() {
        print("si hizo algo");
      });
    } on PlatformException catch (e) {
      e.message;
      //print("Error opening printer: ${e.message}");
    }
  }
}