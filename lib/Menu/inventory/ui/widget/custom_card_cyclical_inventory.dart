import 'package:flutter/material.dart';
import 'package:gomart/Menu/inventory/ui/screen/product_cyclical_inventory_screen.dart';
import '../../model/cyclical_inventory_model.dart';
import '../screen/inventory_screen.dart';

class CustomCardCyclicalInventory extends StatefulWidget {
  final int index;
  final List<CyclicalInventoryModel>? listCyclicalInventoryModel;
  const CustomCardCyclicalInventory({super.key, required this.index, required this.listCyclicalInventoryModel});

  @override
  State<CustomCardCyclicalInventory> createState() => _CustomCardCyclicalInventoryState();
}

class _CustomCardCyclicalInventoryState extends State<CustomCardCyclicalInventory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
                color: Colors.cyan
                ),
            child: Center(
                child: Text(widget.listCyclicalInventoryModel![widget.index].nameCyclicalInventory,
                  style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                )
            ),
        ),
        const SizedBox(height: 15,),
        //Text(widget.listCyclicalInventoryModel![widget.index].inventoryTypeName),
        Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text("Categoria: ${widget.listCyclicalInventoryModel![widget.index].category}",
                      style: const TextStyle(
                          fontSize: 16.0),
                    ),
                    Text("Frecuencia: ${widget.listCyclicalInventoryModel![widget.index].frequency}",
                        style: const TextStyle(
                            fontSize: 16.0)
                    ),
                    Text("Sub Frecuencia: ${widget.listCyclicalInventoryModel![widget.index].subFrequency}",
                        style: const TextStyle(
                            fontSize: 16.0)
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    debugPrint("Se le dio click a ${widget.listCyclicalInventoryModel![widget.index].id}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductCyclicalInventoryScreen(cyclicalInventoryId: widget.listCyclicalInventoryModel![widget.index].id)),
                    );
                  },
                  child: const Icon(
                    Icons.navigate_next_sharp,
                    size: 60,
                    color: Colors.cyan,
                  ),
                )
              ],
            ),
          ],
        ),
        const SizedBox(height: 15,)
        //Text("${widget.listCyclicalInventoryModel![widget.index].frequencyDays}"),
        //Text(widget.listCyclicalInventoryModel![widget.index].specificTime),
      ],
    );
  }
}
