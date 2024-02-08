import 'package:flutter/material.dart';

import '../Constants/app_colors.dart';


class RoundTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Color? bgColor;
  final Widget? left;
  final String? Function(String?)? validator;

  const RoundTextfield(
      {super.key,
      this.controller,
      required this.hintText,
      this.keyboardType,
      this.obscureText = false,
      this.bgColor,
      this.left,
      required this.validator,});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bgColor ?? TColor.textField,
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          if (left != null) Padding(
              padding: const EdgeInsets.only(left: 15,),
              child: left!,
            ),
          Expanded(
            child: TextFormField(
              autocorrect: false,
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              validator: validator,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                    color: TColor.primaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
