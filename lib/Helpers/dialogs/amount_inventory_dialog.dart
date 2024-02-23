
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/dialogInputs/dialog_input_add_amount_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/dialogInputs/dialog_input_add_amount_event.dart';
import 'package:gomart/Menu/inventory/bloc/dialogInputs/dialog_input_add_amount_state.dart';
import 'package:gomart/Menu/inventory/bloc/input/input_add_amount_bloc.dart';
import 'package:gomart/Menu/inventory/model/product_model.dart';

import '../../Constants/app_colors.dart';
import '../../Menu/inventory/bloc/input/input_add_amount_event.dart';
import '../get_color_hexadecimal.dart';

class AmountInventoryDialog {
  final BuildContext context;
  late BuildContext contextDialog;
  final String? title;
  final String? description;
  //final VoidCallback? onCancel;
  //final VoidCallback? onOk;
  final ProductModel? productModel;

  AmountInventoryDialog({
    required this.context,
    this.title,
    this.description,
    //this.onCancel,
    //this.onOk,
    this.productModel
});

  void showDialog(ProductModel product) {
    TextEditingController productAmountController = TextEditingController();
    AwesomeDialog(
        context: context,
        dialogType: DialogType.infoReverse,
        animType: AnimType.scale,
        showCloseIcon: false,
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        body: BlocProvider<DialogInputAddAmountBloc>(create: (context) => DialogInputAddAmountBloc(),
          child: Center(
            child: BlocBuilder<DialogInputAddAmountBloc, DialogInputAddAmountState>(builder: (contextInputAddAmount, stateInputAddAmount){
              contextDialog = contextInputAddAmount;
              return Column(
                children: [
                  Text(product.name,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: TColor.primaryText),
                      textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10,),

                  if (product.physicalInventory != 0)
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Color(getColorHexadecimal(primaryColor)),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(35),
                          bottomRight: Radius.circular(35),
                          topLeft: Radius.circular(35),
                          bottomLeft: Radius.circular(35)),
                    ),
                    child: Center(
                      child: Text("${product.physicalInventory}",
                        style: TextStyle(
                          color: TColor.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),


                  const SizedBox(height: 15,),

                  TextField(
                    controller: productAmountController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 4,
                    decoration: InputDecoration(
                      hintText: 'Ingresa una cantidad',
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                      errorText: stateInputAddAmount.isValidAmount
                          ? '                Por favor, ingresa una cantidad'
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
                  )
                ],
              );
            },),
          ),
        ),
        btnOkText: "ACEPTAR",
        btnOkOnPress: (){
          var amount = productAmountController.text;
          if (amount.isEmpty){
            contextDialog.read<DialogInputAddAmountBloc>().add(ValidateInputAddAmountEvent(isValidAmount: true));
            return;
          } else {
            context.read<InputAddAmountBloc>().add(InputAmountEvent(id: product.id, amount: int.parse(amount)));
            Navigator.of(context).pop();
          }
        },
        btnCancelText: "CANCELAR",
        btnCancelOnPress: (){
          Navigator.of(context).pop();
        },
        autoDismiss: false,
        onDismissCallback:(dismissType){

        }
    ).show();
  }
}