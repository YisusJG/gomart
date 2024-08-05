import 'package:flutter/material.dart';
import 'package:gomart/Constants/app_colors.dart';
import 'package:gomart/Helpers/get_color_hexadecimal.dart';
import 'package:gomart/Menu/inventory/model/cyclical_inventory_product_model.dart';
import 'package:gomart/Menu/inventory/ui/widget/card_list_products_cyclical_inventory_detail.dart';

class CardListProductsCyclicalInventory extends StatefulWidget {
  final List<CyclicalInventoryProductModel> listCyclicalInventoryModel;
  final int categoryId;
  const CardListProductsCyclicalInventory({
    super.key,
    required this.listCyclicalInventoryModel,
    required this.categoryId,
   });

  @override
  State<CardListProductsCyclicalInventory> createState() => _CardListProductsCyclicalInventoryState();
}

class _CardListProductsCyclicalInventoryState extends State<CardListProductsCyclicalInventory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  width: MediaQuery.of(context).size.width * 0.28,
                  decoration: BoxDecoration(
                    color: Color(getColorHexadecimal(primaryColor)),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(35),
                        bottomRight: Radius.circular(35)),
                  ),
                ),
              ),
              CardListProductsCyclicalInventoryDetail(
                listCyclicalInventoryProductModel: widget.listCyclicalInventoryModel,
                categoryId: widget.categoryId,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
