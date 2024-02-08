import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/purchaseOrderDetail/models/note_model.dart';
import '../../Menu/purchaseOrderDetail/bloc/dialogInputs/dialog_input_bloc.dart';
import '../../Menu/purchaseOrderDetail/bloc/dialogInputs/dialog_input_event.dart';
import '../../Menu/purchaseOrderDetail/bloc/dialogInputs/dialog_input_state.dart';
import '../../Menu/purchaseOrderDetail/bloc/inputs/purchase_order_detail_inputs_bloc.dart';
import '../../Menu/purchaseOrderDetail/bloc/inputs/purchase_order_detail_inputs_event.dart';
import '../../Menu/purchaseOrderDetail/bloc/reception/purchase_order_list_bloc.dart';
import '../../Menu/purchaseOrderDetail/bloc/reception/purchase_order_list_event.dart';
import '../../Menu/purchaseOrderDetail/models/reception_detail_model.dart';

class PurchaseDetailDialog {
  final BuildContext context;
  late BuildContext contextDialog;
  final String? title;
  final String? description;
  final VoidCallback? onCancel;
  final VoidCallback? onOk;
  //final PurchaseOrderDetailModel purchaseOrderDetailModel;

  PurchaseDetailDialog(
      {
        required this.context,
        this.title,
        this.description,
        this.onCancel,
        this.onOk,
        //PurchaseOrderDetailModel? purchaseOrderDetail,
      }); //: purchaseOrderDetailModel = purchaseOrderDetail ?? PurchaseOrderDetailModel();

  void showDialogInfoInput(ReceptionDetailModel receptionDetailModel) {
    TextEditingController productCostController = TextEditingController();
    TextEditingController amountReceivedController = TextEditingController();
    List<NoteModel> dropdownItems = NoteModel.notes;
    NoteModel? selectedOption;
    String typeNoteDescription = '';
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
                  Text(receptionDetailModel.productName,
                      style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black26)),
                  TextField(
                    controller: productCostController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Costo del producto',
                      border:  OutlineInputBorder(borderRadius:BorderRadius.circular(15)),
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
                      border:  OutlineInputBorder(borderRadius:BorderRadius.circular(15)),
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
                  const SizedBox(height: 10,),
                  // TextField(
                  //   controller: dicountController,
                  //   keyboardType: TextInputType.number,
                  //   textAlign: TextAlign.center,
                  //   decoration: InputDecoration(
                  //     hintText: 'Descuento',
                  //     border:  OutlineInputBorder(borderRadius:BorderRadius.circular(15)),
                  //     contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                  //   ),
                  // ),
                  // const SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child:DropdownButtonFormField<NoteModel>(
                      hint: const Text('Tipo de nota'),
                      value: selectedOption,
                      isExpanded: true,
                      padding: const EdgeInsets.only(left: 8),
                      alignment: Alignment.center,
                      //underline: const SizedBox(),
                      borderRadius: BorderRadius.circular(10),
                      items: dropdownItems.map((NoteModel value){
                        return DropdownMenuItem<NoteModel>(
                            value: value,
                            child: Text(value.description));
                      }).toList(),
                      onChanged: (NoteModel? newValue){
                        typeNoteDescription = newValue?.description ?? '';
                        selectedOption = newValue;
                        //print("Valor del tipeDocument ${selectedOption!.id}");
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none
                      ),
                    ),
                  )

                ],
              );
            })
        ),
      ),
      btnOkText: "ACEPTAR",
      btnOkOnPress: () {
        var producstCost = productCostController.text;
        var amountReceived = amountReceivedController.text;
        //var discount = dicountController.text;
        if(producstCost.isEmpty){
          contextDialog.read<DialogInputBloc>().add(ValidateInputDialogEvent(isvalidateCost: true, isValidaAmount: false));
          return;
        }if(amountReceived.isEmpty){
          contextDialog.read<DialogInputBloc>().add(ValidateInputDialogEvent(isValidaAmount: true, isvalidateCost: false));
          return;
        }if(receptionDetailModel.poquantity < int.parse(amountReceived)){
          Navigator.of(context).pop();
          messageSnackBar("No puedes recibir más de la cantidad solicitada");
          return;
        }
        else{
          double subtotal = double.parse(producstCost) * int.parse(amountReceived);
          DateTime now = DateTime.now();
          String insertDate = now.toIso8601String();
          //if(discount.isNotEmpty) discountProduct = double.parse(discount);
          double total = subtotal + receptionDetailModel.iva + receptionDetailModel.ieps;   //- discountProduct;
          // context.read<PurchaseOrderDatailInputsBloc>().add(
          //   InputProductCostEvent(productCost: double.parse(producstCost),id: receptionDetailModel.productId,amountreceived: int.parse(amountReceived),
          //       note:typeNoteDescription,subTotal: subtotal,discount: discount.isEmpty ? 0.0: double.parse(discount),inserDate: insertDate,total: total),
          // );
          context.read<PurchaseOrderDatailInputsBloc>().add(
            InputProductCostEvent(productCost: double.parse(producstCost),id: receptionDetailModel.productId,amountreceived: int.parse(amountReceived),
                note:typeNoteDescription,subTotal: subtotal,discount: 0,inserDate: insertDate,total: total, isReceived: true),
          );

          context.read<PurchaseOrderListBloc>().add(SumOrderTotalsEvent(totalQuantity: int.parse(amountReceived), ieps: receptionDetailModel.ieps * int.parse(amountReceived),
              iva: receptionDetailModel.iva * int.parse(amountReceived),subTotal: subtotal,total: 0,discount: 0));
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