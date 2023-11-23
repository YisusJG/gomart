import 'package:flutter/material.dart';

import '../../../../Constants/app_colors.dart';
import '../../../../Helpers/get_color_hexadecimal.dart';
import '../../models/options.dart';


class CustomOvalButton extends StatefulWidget {
  const CustomOvalButton({super.key, required this.menu});

  final Options menu;

  @override
  State<CustomOvalButton> createState() => _CustomOvalButtonState();
}

class _CustomOvalButtonState extends State<CustomOvalButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 4.6,
      width: MediaQuery.of(context).size.width / 2.3,
      decoration: BoxDecoration(
          color: Color(getColorHexadecimal(primaryColor)),
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () {

          },
          child: Column(
            children: [
              Icon(
                widget.menu.icon,
                color: Color(getColorHexadecimal(secondaryColor)),
                size: 30,
              ),
              Text(
                widget.menu.title,
                style: TextStyle(
                    color: Color(getColorHexadecimal(secondaryColor)),
                    fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
