import 'package:flutter/material.dart';
import 'package:gomart/Menu/sideBar/models/side_menu_item_model.dart';

class SideMenuRow extends StatelessWidget {
  final SideMenuItemModel sideMenuItemModel;
  final String selectedMenu;
  final Function? onMenuPress;
  const SideMenuRow({super.key, required this.sideMenuItemModel, this.selectedMenu = "Inicio", this.onMenuPress});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(duration: const Duration(milliseconds: 300),
          width: selectedMenu == sideMenuItemModel.title ? 288 - 16 : 0,
          height: 36,
          decoration:  BoxDecoration(color: Colors.cyan,
            borderRadius: BorderRadius.circular(10)
          ),
        ),
        InkWell(
          onTap: onMenuPressed,
          child: Row(
            children: [
              SizedBox(
                width: 62,
                height: 32,
                child: Opacity(opacity: 0.7,
                  child: Icon(sideMenuItemModel.icon,color: Colors.white,size: 30,),
                ),
              ),
              Text(sideMenuItemModel.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 17
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void onMenuPressed(){
    debugPrint("entra");
    onMenuPress!();
  }
}
