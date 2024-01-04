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

  TypeDialog(
      {required this.context,
        this.title,
        this.description,
        this.onCancel,
        this.onOk,
        TextEditingController? observationsController,
      }) : observationsController = observationsController ?? TextEditingController();

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

  void showDialogQuestion() {
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
      btnCancelText: "Cancelar",
     // btnCancelIcon: Icons.cancel,
      btnOkOnPress: onOk,
      btnOkText: "Aceptar",
      //btnOkIcon: Icons.check_circle_rounded,
    ).show();
  }
}
