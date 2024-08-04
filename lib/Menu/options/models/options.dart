import 'package:flutter/material.dart';

class Options{

  int id;
  String title;
  Color backgroundColor, textColor;
  IconData icon;

  Options({
    this.id = 0,
    this.title = "",
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.icon = Icons.access_alarm,
});

  static List<Options> menu = [
    Options(
      id: 1,
      title: "Recepción",
      backgroundColor: Colors.black,
      textColor: Colors.white,
      icon: Icons.add_business
    ),
    Options(
        id: 2,
        title: "Inventarios",
        backgroundColor: Colors.black,
        textColor: Colors.white,
        icon: Icons.qr_code_scanner_outlined
    ),
    /*Options(
        id: 3,
        title: "Impresora",
        backgroundColor: Colors.black,
        textColor: Colors.white,
        icon: Icons.print_sharp
    ),*/
    Options(
        id: 3,
        title: "Inv - Ciclicos",
        backgroundColor: Colors.black,
        textColor: Colors.white,
        icon: Icons.inventory_sharp
    )
  ];

}