import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gomart/Menu/purchaseOrder/models/type_document_reception_model.dart';

class PurchaseOrderDialog{
  final BuildContext context;
  final VoidCallback? onCancel;
  final VoidCallback? onOk;
  final TextEditingController providerReferenceController;
  final TextEditingController typeDocumentController;
  final TextEditingController descriptionController;
  final TextEditingController reasonForCancellationController;

  PurchaseOrderDialog(
      {required this.context,
        this.onCancel,
        this.onOk,
        TextEditingController? providerCpntroller,
        TextEditingController? typeDocumentController,
        TextEditingController? descriptionController,
        TextEditingController? reasonForCancellationController,
      })
      : providerReferenceController = providerCpntroller ?? TextEditingController()
      , typeDocumentController = typeDocumentController ?? TextEditingController()
      , descriptionController = descriptionController ?? TextEditingController()
      , reasonForCancellationController = reasonForCancellationController ?? TextEditingController();

  void showPurchaseReferenceDialog(List<TypeDocumentReceptionModel> dropdownItems){
    TypeDocumentReceptionModel? selectedOption;
    // List<TypeDocumentReceptionModel> dropdownItems = [
    //   TypeDocumentReceptionModel(id: 1,name: 'Tickets'),
    //   TypeDocumentReceptionModel(id: 2,name: 'Notas de remision'),
    //   TypeDocumentReceptionModel(id: 3,name: 'Factura'),];
    AwesomeDialog(
      context: context,
      dialogType: DialogType.infoReverse,
      animType: AnimType.rightSlide,
      showCloseIcon: false,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      body: Center(
        child: Column(
          children: [
            const Text("REFERENCIA DE LA ORDEN",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black26)),
            const SizedBox(height: 20,),
            TextField(
              controller: providerReferenceController,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              decoration:  InputDecoration(
                hintText: 'Referencia proveedor',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                // errorText: isValid ? null : 'Por favor, ingrese una referencia',
                // errorBorder: const OutlineInputBorder(
                //   borderSide: BorderSide(
                //     color: Colors.red,
                //     width: 2.0,
                //   ),
                // ),
                // focusedErrorBorder: const OutlineInputBorder(
                //   borderSide: BorderSide(
                //     color: Colors.red,
                //     width: 2.0,
                //   ),
                // ),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(15)
              ),
              child: DropdownButtonFormField<TypeDocumentReceptionModel>(
                  hint: const Text('Tipo de documento'),
                  value: selectedOption,
                  isExpanded: true,
                  padding: const EdgeInsets.only(left: 8),
                  alignment: Alignment.center,
                  //underline: const SizedBox(),
                  borderRadius: BorderRadius.circular(10),
                  items: dropdownItems.map((TypeDocumentReceptionModel value){
                    return DropdownMenuItem<TypeDocumentReceptionModel>(
                        value: value,
                        child: Text(value.name));
                  }).toList(),
                  onChanged: (TypeDocumentReceptionModel? newValue){
                    typeDocumentController.text = newValue?.id.toString() ?? '';
                    selectedOption = newValue;
                    //print("Valor del tipeDocument ${selectedOption!.id}");
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none
                  ),
                ),
            ),



          ],
        ),
      ),
      btnCancelOnPress: onCancel,
      btnCancelText: "Cancelar",
      btnOkOnPress: onOk,
      btnOkText: "Aceptar",
      autoDismiss: false,
      onDismissCallback:(dismissType){

      },
    ).show();
  }


  void cancelPurchaseOrderDialog(){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.infoReverse,
      animType: AnimType.leftSlide,
      showCloseIcon: false,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      body:  Center(
        child: Column(
          children: [
            // const Text("por favor ingresa una observación",
            //     style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 10,),
            TextField(
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Observaciones',
                border:  OutlineInputBorder(borderRadius:BorderRadius.circular(15)),
                contentPadding:  const EdgeInsets.symmetric(vertical: 15.0),
              ),
            ),

          ],
        ),
      ),
      btnCancelOnPress: onCancel,
      btnCancelText: "Cancelar",
      btnCancelIcon: Icons.cancel,
      btnOkOnPress: onOk,
      btnOkText: "Aceptar",
      btnOkIcon: Icons.check_circle_rounded,
    ).show();
  }
}