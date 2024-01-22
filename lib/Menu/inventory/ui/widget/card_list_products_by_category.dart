import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Helpers/dialogs/amount_inventory_dialog.dart';
import 'package:gomart/Menu/inventory/model/product_model.dart';

import '../../../../Constants/app_colors.dart';
import '../../../../Helpers/get_color_hexadecimal.dart';
import '../../../../Helpers/scan_barcode_channel.dart';
import '../../bloc/api/productsByCategory/products_by_category_bloc.dart';
import '../../bloc/api/productsByCategory/products_by_category_event.dart';
import '../../bloc/api/productsByCategory/products_by_category_state.dart';
import '../../bloc/barcode/inventory_barcode_bloc.dart';
import '../../bloc/barcode/inventory_barcode_event.dart';
import '../../bloc/barcode/inventory_barcode_state.dart';
import '../../model/product_category_model.dart';
import 'card_list_products_by_category_detail.dart';

class CardListProductsByCategory extends StatefulWidget {
  final ProductCategoryModel selectedProductCategory;

  const CardListProductsByCategory({super.key, required this.selectedProductCategory});

  @override
  State<CardListProductsByCategory> createState() =>
      _CardListProductsByCategoryState();
}

class _CardListProductsByCategoryState
    extends State<CardListProductsByCategory> {
  ScanBarcodeChannel barcodeChannel = ScanBarcodeChannel();
  static const MethodChannel scannerChannel = MethodChannel('barcode_channel');

  ProductCategoryModel? previousCategory;
  var visibleAmount = false;

  @override
  void initState() {
    super.initState();
    scannerChannel.setMethodCallHandler((call) {
      if (call.method == 'scanBarcode') {
        context.read<InventoryBarcodeBloc>().add(
              BarcodeEvent(barcode: call.arguments),
            );
      }
      return Future.value();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsByCategoryBloc, ProductsByCategoryState>(
        builder: (contextProduct, stateProduct) {
      if (widget.selectedProductCategory != previousCategory) {
        previousCategory = widget.selectedProductCategory;
        contextProduct
            .read<ProductsByCategoryBloc>()
            .add(LoadProductsByCategoryEvent(categoryId: widget.selectedProductCategory.id));
      }
      return BlocListener<InventoryBarcodeBloc, InventoryBarcodeState>(
        listener: (contextBarcodeListener, stateBarcodeListener) {

          var product = stateProduct.productModel
              ?.where((x) => x.barcode == stateBarcodeListener.barcode);
          if (product!.isNotEmpty) {
            showDialogAmountInventory(product.first);
          } else {
            messagesSnackBar("El producto no pertenece a esta categoria");
          }
        },
        child: (stateProduct.productModel != null)
            ? Expanded(
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width * 0.28,
                      decoration: BoxDecoration(
                        color: Color(getColorHexadecimal(primaryColor)),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(35),
                            bottomRight: Radius.circular(35)),
                      ),
                    ),
                    CardListProductsByCategoryDetail(
                      lstProductsModel: stateProduct.productModel!,
                        categoryId: previousCategory!.id
                    ),
                    /*ListView.builder(
                      itemCount: stateProduct.productModel!.length,
                      itemBuilder: (context, index) {
                        var currentProduct = stateProduct.productModel![index];
                        return Stack(
                          children: [
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8, top: 15),
                                width: MediaQuery.of(context).size.width - 50,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.only(
                                        topLeft:
                                        Radius.circular(
                                            25),
                                        bottomLeft:
                                        Radius.circular(
                                            10),
                                        topRight:
                                        Radius.circular(
                                            10),
                                        bottomRight:
                                        Radius.circular(
                                            25)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 7,
                                          offset: Offset(0, 4))
                                    ]),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        currentProduct.name,
                                        style: TextStyle(
                                            color: TColor
                                                .primaryText,
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight
                                                .w700),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        currentProduct.barcode,
                                        style: TextStyle(
                                            color: TColor
                                                .secondaryText),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        currentProduct.purchaseUnit,
                                        style: TextStyle(
                                            color: TColor
                                                .secondaryText),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: currentProduct.id == stateInputAmout.id && stateInputAmout.amount != 0 ? true : false,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width - 45,
                                    top: MediaQuery.of(context).size.height * 0.06),
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    color:
                                    Color(getColorHexadecimal(primaryColor)),
                                    borderRadius: BorderRadius.circular(17.5),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 4,
                                          offset: Offset(0, 2))
                                    ]),
                                alignment: Alignment.center,
                                child: Text(stateInputAmout.amount.toString(),
                                  style: TextStyle(
                                      color: TColor.white),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),*/
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      );
    });
  }

  void showDialogAmountInventory(ProductModel productModel) {
    AmountInventoryDialog dialog = AmountInventoryDialog(context: context);
    dialog.showDialog(productModel);
  }

  void messagesSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
