import 'package:flutter/material.dart';
import 'package:gomart/Helpers/scan_barcode_channel.dart';

class PurchaseOrderDetail extends StatefulWidget {
  const PurchaseOrderDetail({super.key});

  @override
  State<PurchaseOrderDetail> createState() => _PurchaseOrderDetailState();
}

class _PurchaseOrderDetailState extends State<PurchaseOrderDetail> {
  ScanBarcodeChannel barcodeChannel = ScanBarcodeChannel();
  //static const MethodChannel scannerChannel = MethodChannel('printer_channel');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear codigo de barras'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _printMessage();
          },
          child: const Text('scanear'),
        ),
      ),
    );
  }

  void _printMessage() async {
    try {
      await barcodeChannel.prueba();
    } catch (e) {
      print('Error al scanear: $e');
    }
  }
}
