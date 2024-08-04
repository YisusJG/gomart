import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Constants/app_colors.dart';
import 'package:gomart/Helpers/dialogs/amount_inventory_dialog.dart';
import 'package:gomart/Helpers/get_color_hexadecimal.dart';
import 'package:gomart/Helpers/scan_barcode_channel.dart';
import 'package:gomart/Menu/inventory/bloc/barcode/inventory_barcode_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/barcode/inventory_barcode_event.dart';
import 'package:gomart/Menu/inventory/bloc/barcode/inventory_barcode_state.dart';
import 'package:gomart/Menu/inventory/bloc/input/input_add_amount_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/input/input_add_amount_state.dart';
import 'package:gomart/Menu/inventory/model/cyclical_inventory_product_model.dart';

class CardListProductsCyclicalInventoryDetail extends StatefulWidget {
  final List<CyclicalInventoryProductModel> listCyclicalInventoryProductModel;

  const CardListProductsCyclicalInventoryDetail({
    super.key,
    required this.listCyclicalInventoryProductModel
  });

  @override
  State<CardListProductsCyclicalInventoryDetail> createState() => _CardListProductsCyclicalInventoryDetailState();
}

class _CardListProductsCyclicalInventoryDetailState extends State<CardListProductsCyclicalInventoryDetail> {
  final ScanBarcodeChannel barcodeChannel = ScanBarcodeChannel();
  static const MethodChannel scannerChannel = MethodChannel('barcode_channel');
  final ScrollController scrollController = ScrollController();

  late final InventoryBarcodeBloc inventoryBarcodeBloc;

  @override
  void initState() {
    super.initState();
    // Initialize the bloc outside of build
    inventoryBarcodeBloc = InventoryBarcodeBloc();

    scannerChannel.setMethodCallHandler((call) {
      if (call.method == 'scanBarcode') {
        debugPrint("initState ${call.arguments}");
        inventoryBarcodeBloc.add(
          BarcodeEvent(barcode: call.arguments),
        );
      }
      return Future.value();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InventoryBarcodeBloc>.value(
      value: inventoryBarcodeBloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<InventoryBarcodeBloc, InventoryBarcodeState>(
            listener: (contextBarcodeListener, stateBarcodeListener) {
              var productBarcode = widget.listCyclicalInventoryProductModel
                  .where((x) => x.barcode == stateBarcodeListener.barcode ||
                  x.productBarCodes!.any((barcode) => barcode.barcode == stateBarcodeListener.barcode)
              );

              if (productBarcode.isNotEmpty) {
                showDialogAmountInventory(productBarcode.first);
              } else {
                messagesSnackBar("El producto no pertenece a esta categoria");
              }
            },
          ),
        ],
        child: BlocBuilder<InputAddAmountBloc, InputAddAmountState>(
          builder: (contextInputAmout, stateInputAmout) {
            if (stateInputAmout.id > 0) {
              CyclicalInventoryProductModel targetProduct = widget.listCyclicalInventoryProductModel
                  .firstWhere((product) => product.id == stateInputAmout.id);

              targetProduct.count = stateInputAmout.amount;
            }
            return ListView.builder(
                controller: scrollController,
                itemCount: widget.listCyclicalInventoryProductModel.length,
                itemBuilder: (context, index) {
                  var currentProduct = widget.listCyclicalInventoryProductModel[index];
                  return Stack(
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8, top: 15),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 50,
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
                                      25)
                              ),
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
                                  currentProduct.product,
                                  style: TextStyle(
                                      color: TColor
                                          .primaryText,
                                      fontSize: 14,
                                      fontWeight:
                                      FontWeight
                                          .w700),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  currentProduct.barcode,
                                  style: TextStyle(
                                      color: TColor
                                          .secondaryText),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                /*Text(
                                    currentProduct.purchaseUnit,
                                    style: TextStyle(
                                        color: TColor
                                            .secondaryText),
                                  ),*/
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: currentProduct.count != 0 ? true : false,
                        child: Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 45,
                              top: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.06),
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
                          child: Text(currentProduct.count.toString(),
                            style: TextStyle(
                                color: TColor.white),
                          ),
                        ),
                      ),
                    ],
                  );
                });
          },

        ),
      ),
    );
  }

  void showDialogAmountInventory(CyclicalInventoryProductModel cyclicalInventoryProductModel) {
    AmountInventoryDialog dialog = AmountInventoryDialog(context: context);
    dialog.showDialogCyclicalInventory(cyclicalInventoryProductModel);
  }

  void messagesSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
