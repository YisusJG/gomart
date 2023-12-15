import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Menu/purchaseOrderDetail/bloc/dialogInputs/dialog_input_bloc.dart';
import '../../Menu/purchaseOrderDetail/bloc/dialogInputs/dialog_input_event.dart';
import '../../Menu/purchaseOrderDetail/bloc/dialogInputs/dialog_input_state.dart';
import '../../Menu/purchaseOrderDetail/bloc/inputs/purchase_order_detail_inputs_bloc.dart';
import '../../Menu/purchaseOrderDetail/bloc/inputs/purchase_order_detail_inputs_event.dart';
import '../../Menu/purchaseOrderDetail/bloc/lists/purchase_order_list_bloc.dart';
import '../../Menu/purchaseOrderDetail/bloc/lists/purchase_order_list_event.dart';
import '../../Menu/purchaseOrderDetail/models/purchase_order_detail_model.dart';

class PurchaseDetailDialog {
  final BuildContext context;
  late BuildContext contextDialog;
  final String? title;
  final String? description;
  final VoidCallback? onCancel;
  final VoidCallback? onOk;
  final PurchaseOrderDetailModel purchaseOrderDetailModel;

  PurchaseDetailDialog(
      {
        required this.context,
        this.title,
        this.description,
        this.onCancel,
        this.onOk,
        PurchaseOrderDetailModel? purchaseOrderDetail,
      }) : purchaseOrderDetailModel = purchaseOrderDetail ?? PurchaseOrderDetailModel();

  void showDialogInfoInput(PurchaseOrderDetailModel purchaseOrderDetailModel) {
    TextEditingController productCostController = TextEditingController();
    TextEditingController amountReceivedController = TextEditingController();
    AwesomeDialog(
      context: context,
      dialogType: DialogType.infoReverse,
      animType: AnimType.scale,
      showCloseIcon: false,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      body: BlocProvider<DialogInputBloc>(create: (context) => DialogInputBloc(),
        child:Center(
            child: BlocBuilder<DialogInputBloc,DialogInputState>(builder: (contextDialogInput, stateDialogInput){
              contextDialog = contextDialogInput;
              return Column(
                children: [
                  Text(purchaseOrderDetailModel.name!,
                      style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black26)),
                  TextField(
                    controller: productCostController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Costo del producto',
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                      errorText: stateDialogInput.isvalidateCost
                          ? 'Por favor, ingrese el costo del producto'
                          : null,
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: amountReceivedController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Cantidad recepcionada',
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                      errorText: stateDialogInput.isValidateAmount
                          ? 'Por favor, ingrese una cantidad'
                          : null,
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            })
        ),
      ),
      btnOkText: "ACEPTAR",
      btnOkOnPress: () {
        var producstCost = productCostController.text;
        var amountReceived = amountReceivedController.text;
        if(producstCost.isEmpty){
          contextDialog.read<DialogInputBloc>().add(ValidateInputDialogEvent(isvalidateCost: true, isValidaAmount: false));
          return;
        }if(amountReceived.isEmpty){
          contextDialog.read<DialogInputBloc>().add(ValidateInputDialogEvent(isValidaAmount: true, isvalidateCost: false));
          return;
        }if(purchaseOrderDetailModel.quantity < int.parse(amountReceived)){
          Navigator.of(context).pop();
          messageSnackBar("No puedes recibir más de la cantidad solicitada");
          return;
        }
        else{
          context.read<PurchaseOrderDatailInputsBloc>().add(
            InputProductCostEvent(productCost: double.parse(producstCost),id: purchaseOrderDetailModel.id,amountreceived: int.parse(amountReceived)),
          );
          double subtotal = double.parse(producstCost) * int.parse(amountReceived);
          context.read<PurchaseOrderListBloc>().add(SumOrderTotalsEvent(totalQuantity: int.parse(amountReceived), ieps: purchaseOrderDetailModel.ieps, iva: purchaseOrderDetailModel.iva,subTotal: subtotal,total: 0)); //aquoe es una probabilidad de que vaya
          Navigator.of(context).pop();
        }
      },
      btnCancelText: 'CANCELAR',
      //btnCancelIcon:Icons.close,
      btnCancelOnPress: (){
        Navigator.of(context).pop();
      },
      autoDismiss: false,
      onDismissCallback:(dismissType){

      },
    ).show();
  }

  void messageSnackBar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}