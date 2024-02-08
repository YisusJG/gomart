import 'package:flutter/cupertino.dart';

import '../Constants/app_colors.dart';
import '../Helpers/get_color_hexadecimal.dart';

class AppBarMenu extends StatelessWidget {
  const AppBarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width/1,
      height: MediaQuery.of(context).size.width/9,
      decoration: BoxDecoration(
          color: Color(getColorHexadecimal(primaryColor)),
      ),
    );
  }
}
