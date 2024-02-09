import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TypeDialog {

  final BuildContext context;
  final String? title;
  final String? description;
  final VoidCallback? onCancel;
  final VoidCallback? onOk;
  final TextEditingController observationsController;
  final TextEditingController amounController;

  TypeDialog(
      {required this.context,
        this.title,
        this.description,
        this.onCancel,
        this.onOk,
        TextEditingController? observationsController,
        TextEditingController? amountController,
      }) : observationsController = observationsController ?? TextEditingController()
         , amounController = amountController ?? TextEditingController();

  void showDialogConfirm() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.infoReverse,
      animType: AnimType.leftSlide,
      showCloseIcon: false,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      title: title,
      desc: description,
      btnCancelOnPress: onCancel,
      btnCancelText: "Cancelar",
      btnCancelIcon: Icons.cancel,
      btnOkOnPress: onOk,
      btnOkText: "Aceptar",
      btnOkIcon: Icons.check_circle_rounded,
    ).show();
  }

  void showDialogConfirmBody() {
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
              controller: observationsController,
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


  void showDialogSucces() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.topSlide,
      showCloseIcon: false,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      title: title,
      desc: description,
      btnOkIcon: Icons.check_circle_rounded,
      btnOkText: "Aceptar",
      btnOkOnPress: onOk,
    ).show();
  }

  void showDialogInfoLoading(){
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.info,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      body: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10,),
          SpinKitPulsingGrid(
            size: 60,
            color: Colors.green,

          ) ,// Indicador de carga personalizado
          SizedBox(height: 16),
          Text(
            'Cargando evidencias',
            style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18),
          ),
          SizedBox(height: 16),
        ],
      ),
    ).show();
  }

  void showDialogUploading(){
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.info,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      body:  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10,),
          const SpinKitChasingDots(
            size: 60,
            color: Colors.green,

          ) ,// Indicador de carga personalizado
          const SizedBox(height: 16),
          Text(
            description!,
            style: const TextStyle(fontStyle: FontStyle.italic,fontSize: 18),
          ),
          const SizedBox(height: 16),
        ],
      ),
    ).show();
  }

  void showDialogQuestion(String textBtnOk, String textBtnCancel) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.leftSlide,
      showCloseIcon: false,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      title: title,
      desc: description,
      btnCancelOnPress: onCancel,
      btnCancelText: textBtnCancel,
     // btnCancelIcon: Icons.cancel,
      btnOkOnPress: onOk,
      btnOkText: textBtnOk,
      //btnOkIcon: Icons.check_circle_rounded,
    ).show();
  }

  void showInputBasicDialog(String productName, String hindText,String btnTextOk, String btnTextCancel) {
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
              Text(productName,
                 style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black,),textAlign: TextAlign.center,),
            const SizedBox(height: 10,),
            TextField(
              controller: amounController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: '${hindText}s',
                border:  OutlineInputBorder(borderRadius:BorderRadius.circular(15)),
                contentPadding:  const EdgeInsets.symmetric(vertical: 15.0),
              ),
            ),

          ],
        ),
      ),
      btnCancelOnPress: onCancel,
      btnCancelText: btnTextCancel,
      //btnCancelIcon: Icons.cancel,
      btnOkOnPress: onOk,
      btnOkText: btnTextOk,
      //btnOkIcon: Icons.check_circle_rounded,
    ).show();
  }

  void showDialogWarning() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      showCloseIcon: false,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      title: title,
      desc: description,
      btnOkIcon: Icons.check_circle_rounded,
      btnOkText: "Aceptar",
      btnOkOnPress: () {},
    ).show();
  }

  void showDialogError() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      showCloseIcon: false,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      title: title,
      desc: description,
      btnOkIcon: Icons.check_circle_rounded,
      btnOkText: "Aceptar",
      btnOkOnPress: () {},
    ).show();
  }


  void showDialogQuestion2(String textBtnOk, String textBtnCancel) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.leftSlide,
      showCloseIcon: false,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      title: title,
      desc: description,
      btnCancelOnPress: onCancel,
      btnCancelText: textBtnCancel,
      // btnCancelIcon: Icons.cancel,
      btnOkOnPress: onOk,
      btnOkText: textBtnOk,
      //btnOkIcon: Icons.check_circle_rounded,
    ).show();
  }

}
