import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TypeDialog {

  final BuildContext context;
  final String? title;
  final String? description;
  final VoidCallback? onCancel;
  final VoidCallback? onOk;

  TypeDialog(
      {required this.context,
        this.title,
        this.description,
        this.onCancel,
        this.onOk,
      });

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
}
