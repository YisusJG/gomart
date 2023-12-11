import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Menu/purchaseOrderDetail/bloc/inputs/purchase_order_detail_inputs_bloc.dart';
import '../Menu/purchaseOrderDetail/bloc/inputs/purchase_order_detail_inputs_event.dart';
import '../Menu/purchaseOrderDetail/bloc/lists/purchase_order_list_bloc.dart';
import '../Menu/purchaseOrderDetail/bloc/lists/purchase_order_list_event.dart';
import '../Menu/purchaseOrderDetail/models/purchase_order_detail_model.dart';

class TypeDialog {
  final BuildContext context;
  final String? title;
  final String? description;
  final VoidCallback? onCancel;
  final VoidCallback? onOk;
  final PurchaseOrderDetailModel purchaseOrderDetailModel;

  TypeDialog(
      {
        required this.context,
        this.title,
        this.description,
        this.onCancel,
        this.onOk,
        PurchaseOrderDetailModel? purchaseOrderDetail,
      }):
        purchaseOrderDetailModel = purchaseOrderDetail ?? PurchaseOrderDetailModel();

  void showDialogInfoInput() {
    TextEditingController productCostController = TextEditingController();
    TextEditingController amountReceivedController = TextEditingController();
    AwesomeDialog(
      context: context,
      dialogType: DialogType.infoReverse,
      animType: AnimType.scale,
      showCloseIcon: true,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      body: Center(
          child: Column(
            children: [
               Text(purchaseOrderDetailModel.name!,
                  style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black26)),
              TextField(
                controller: productCostController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Costo del producto',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                  // errorText: productCostController.text.isEmpty
                  //     ? 'Por favor, ingrese el costo del producto'
                  //     : null,
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: amountReceivedController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Cantidad recepcionada',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                  // errorText: productCostController.text.isEmpty
                  //     ? 'Por favor, ingrese el costo del producto'
                  //     : null,
                ),
              ),
            ],
          )
      ),
      btnOkIcon: Icons.check_circle_rounded,
      btnOkText: "Aceptar",
      btnOkOnPress: () {
       // print("Valor texto ${amountReceivedController.text}");
        var producstCost = productCostController.text;
        var amountReceived = amountReceivedController.text;
        if(producstCost.isEmpty){
          print("No se agrego una coantidad");
          // AwesomeDialog().info("Por favor, ingrese una cantidad.").show();
        }else{
          context.read<PurchaseOrderDatailInputsBloc>().add(
            InputProductCostEvent(productCost: double.parse(producstCost),id: purchaseOrderDetailModel.id,amountreceived: int.parse(amountReceived)),

          );
          double subtotal = double.parse(producstCost) * int.parse(amountReceived);
          context.read<PurchaseOrderListBloc>().add(SumOrderTotalsEvent(totalQuantity: int.parse(amountReceived), ieps: 2.2, iva: 16.0,subTotal: subtotal,total: 29)); //aquoe es una probabilidad de que vaya

        }
      },
      //autoDismiss: false,
      // onDismissCallback:(dismissType){
      //   print("Cerrar ${dismissType.index}");
      //   if (dismissType.index ==2) {
      //     //Navigator.of(context).pop();
      //     print('seciera desde el icono');
      //   }
      //   if(dismissType.index == 0){
      //     print('se cierra desde el boton');
      //     return;
      //   }
      //
      // }
    ).show();
  }
}
