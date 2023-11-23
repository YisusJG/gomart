import 'package:flutter/material.dart';

class Options{
  Options({
    this.id,
    this.title = "",
    this.bacgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.icon = Icons.access_alarm,
});

  UniqueKey? id = UniqueKey();
  String title;
  Color bacgroundColor, textColor;
  IconData icon;

  static List<Options> menu = [
    Options(
      title: "Recepción",
      bacgroundColor: Colors.black,
      textColor: Colors.white,
      icon: Icons.add_business
    ),
    Options(
        title: "Inventarios",
        bacgroundColor: Colors.black,
        textColor: Colors.white,
        icon: Icons.qr_code_scanner_outlined
    ),
  ];

}