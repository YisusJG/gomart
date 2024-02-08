import 'package:flutter/cupertino.dart';

String? validatePassword(String value, FocusNode focusNodePassword) {
  String pattern = r'(^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$)';
  RegExp regExp = RegExp(pattern);
  if (value.isEmpty) {
    focusNodePassword.requestFocus();
    return "\u{26A0} Ingresa tu Contraseña";
  } else if (!regExp.hasMatch(value)) {
    focusNodePassword.requestFocus();
    return "\u{26A0} Password invalido";
  } else if (value.length < 8) {
    focusNodePassword.requestFocus();
    return "\u{26A0} Minimo 8 caracteres";
  } else {
    return null;
  }
}


String? validateUser(String value, FocusNode focusNodeUser) {
  String pattern = r'(^[0-9]{10}$)';
  RegExp regExp = RegExp(pattern);
  if (value.isEmpty) {
    focusNodeUser.requestFocus();
    return "\u{26A0} Ingresa tu Usuario";
  } else if (!regExp.hasMatch(value)) {
    focusNodeUser.requestFocus();
    return "\u{26A0} Usuario invalido";
  }
  return null;
}

