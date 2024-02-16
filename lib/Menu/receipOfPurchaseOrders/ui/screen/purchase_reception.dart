import 'package:flutter/material.dart';

import '../../../../Constants/app_colors.dart';
import '../../../../Helpers/get_color_hexadecimal.dart';
import '../../../purchaseOrder/models/reference_order_model.dart';

class PurchaseReception extends StatefulWidget {
  final ReferenceOrderModel referenceOrderModel;
  const PurchaseReception({super.key, required this.referenceOrderModel});

  @override
  State<PurchaseReception> createState() => _PurchaseReceptionState();
}

class _PurchaseReceptionState extends State<PurchaseReception> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
        onPopInvoked: (bool didPop){
          if(didPop){
            return;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Recepción de orden", style: TextStyle(color: Color(getColorHexadecimal(secondaryColor)))),
            iconTheme: IconThemeData(color: Color(getColorHexadecimal(secondaryColor))),
            backgroundColor: Color(getColorHexadecimal(primaryColor)),
          ),
          body: Container(color: Colors.red,),
        )
    );
  }
}
