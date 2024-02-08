import 'package:flutter/material.dart';
import 'package:gomart/Constants/app_colors.dart';
import 'package:gomart/Helpers/get_color_hexadecimal.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Usuario"),),
      backgroundColor: Color(getColorHexadecimal(primaryColor)),
    );
  }
}
