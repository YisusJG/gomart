import 'package:flutter/material.dart';
import 'package:gomart/DataBase/entities/branch_entity.dart';

import '../../../../Constants/app_colors.dart';
import '../../../../Helpers/get_color_hexadecimal.dart';

class CustomGomartName extends StatelessWidget {
  final BranchEntity? branchEntity;
  const CustomGomartName({super.key, required this.branchEntity});

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
      child: Text("${branchEntity!.description} - ${branchEntity!.branchNumber}",style: TextStyle(
          color: Color(getColorHexadecimal(secondaryColor)),
          fontSize: 25,
          fontWeight: FontWeight.bold
      ),
      ),
    );
  }
}
