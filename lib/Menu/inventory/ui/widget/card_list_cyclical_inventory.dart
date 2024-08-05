import 'package:flutter/material.dart';
import 'package:gomart/Menu/inventory/model/cyclical_inventory_model.dart';
import 'package:gomart/Menu/inventory/ui/widget/custom_card_cyclical_inventory.dart';

class CardListCyclicalInventory extends StatefulWidget {
  final List<CyclicalInventoryModel>? listCyclicalInventoryModel;
  const CardListCyclicalInventory({super.key, required this.listCyclicalInventoryModel });

  @override
  State<CardListCyclicalInventory> createState() => _CardListCyclicalInventoryState();
}

class _CardListCyclicalInventoryState extends State<CardListCyclicalInventory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.listCyclicalInventoryModel?.length,
              itemBuilder: (context, index) {
                return Container(
                  key: UniqueKey(),
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12.0
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(
                            3.0,
                            3.0,
                          ), //Offset
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ),
                      ]),
                  child: CustomCardCyclicalInventory(
                      index: index,
                      listCyclicalInventoryModel: widget.listCyclicalInventoryModel,
                  ),
                );
              }
            )
        ),
      ],
    );
  }
}
