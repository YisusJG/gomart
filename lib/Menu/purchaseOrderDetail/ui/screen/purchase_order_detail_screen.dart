import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gomart/Helpers/scan_barcode_channel.dart';

class PurchaseOrderDetail extends StatefulWidget {
  const PurchaseOrderDetail({super.key});

  @override
  State<PurchaseOrderDetail> createState() => _PurchaseOrderDetailState();
}

class _PurchaseOrderDetailState extends State<PurchaseOrderDetail> {
  ScanBarcodeChannel barcodeChannel = ScanBarcodeChannel();
  static const MethodChannel scannerChannel = MethodChannel('barcode_channel');
  String barcode = '';
  //static const MethodChannel scannerChannel = MethodChannel('printer_channel');

  @override
  void initState() {
    super.initState();
    scannerChannel.setMethodCallHandler((call) {
      if (call.method == 'scanBarcode') {
        setState(() {
          barcode = call.arguments;
        });
      }
      return Future.value();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear codigo de barras'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(barcode)
          ],
        )
      ),
    );
  }

  // void _printMessage() async {
  //   try {
  //     await barcodeChannel.prueba();
  //   } catch (e) {
  //     print('Error al scanear: $e');
  //   }
  // }
}
