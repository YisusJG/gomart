import 'package:flutter/material.dart';

class SideMenuItemModel{
  int id;
  String title;
  IconData icon;

  SideMenuItemModel({
    this.id = 0,
    this.title = "",
    this.icon = Icons.access_alarm,
  });

  static List<SideMenuItemModel> sideMenuItems = [
    SideMenuItemModel(id: 1, title: "Inicio",icon:  Icons.home),
    SideMenuItemModel(id: 1, title: "Buscar",icon:  Icons.search),
    SideMenuItemModel(id: 1, title: "Favoritos",icon:  Icons.star),
    SideMenuItemModel(id: 1, title: "Mensajes",icon:  Icons.chat),
  ];

  static List<SideMenuItemModel> sideMenuItems2 = [
    SideMenuItemModel(id: 1, title: "Borrar datos",icon:  Icons.double_arrow_rounded),
  ];
}