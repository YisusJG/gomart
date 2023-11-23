import 'package:flutter/material.dart';

import '../../../../Constants/app_colors.dart';
import '../../../../Helpers/get_color_hexadecimal.dart';

class CustomGomartName extends StatelessWidget {
  const CustomGomartName({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width/1,
      height: MediaQuery.of(context).size.width/6,
      decoration: BoxDecoration(
          color: Color(getColorHexadecimal(primaryColor)),
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40) )
      ),
      child: Text("REFORMA 155 - G137",style: TextStyle(
          color: Color(getColorHexadecimal(secondaryColor)),
          fontSize: 25,
          fontWeight: FontWeight.bold
      ),
      ),
    );
  }
}
