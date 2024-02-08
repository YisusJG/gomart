import 'package:flutter/material.dart';
import 'package:gomart/Menu/inventory/ui/screen/inventory_screen.dart';
import 'package:gomart/Menu/purchaseOrder/ui/screen/purchase_orders_screen.dart';
import 'package:gomart/Menu/thermalPrint/ui/screen/thermal_print_screen.dart';
import '../../../../Constants/app_colors.dart';
import '../../../../Helpers/get_color_hexadecimal.dart';
import '../../models/options.dart';


class CustomOvalButton extends StatefulWidget {
  final Options menu;
  const CustomOvalButton({super.key, required this.menu});

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
           selectedOption(widget.menu.id);
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
                    fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }

  void selectedOption(int option){
    if(option == 1){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PurchaseOrdersScreen()),
      );
    }if(option ==2){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const InventoryScreen()),
      );
    }if(option ==3){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ThermalPrintScreen()),
      );
    }
  }

  void messagesSnackBar(String message){
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
