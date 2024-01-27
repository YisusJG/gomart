import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/buttonSaveInventory/click_button_save_inventory_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/buttonSaveInventory/click_button_save_inventory_state.dart';
import 'package:gomart/Menu/inventory/bloc/input/input_add_amount_event.dart';
import 'package:gomart/Menu/inventory/bloc/list/products_inventory_list_state.dart';

import '../../../../Constants/app_colors.dart';
import '../../../../Helpers/dialogs/type_dialog.dart';
import '../../../../Helpers/get_color_hexadecimal.dart';
import '../../bloc/input/input_add_amount_bloc.dart';
import '../../bloc/input/input_add_amount_state.dart';
import '../../bloc/list/products_inventory_list_bloc.dart';
import '../../bloc/list/products_inventory_list_event.dart';
import '../../model/product_category_model.dart';
import '../../model/product_model.dart';

class CardListProductsByCategoryDetail extends StatefulWidget {
  final List<ProductModel> lstProductsModel;
  final ProductCategoryModel selectedProductCategory;
  const CardListProductsByCategoryDetail({super.key, required this.lstProductsModel, required this.selectedProductCategory});

  @override
  State<CardListProductsByCategoryDetail> createState() => _CardListProductsByCategoryDetailState();
}

class _CardListProductsByCategoryDetailState extends State<CardListProductsByCategoryDetail> {

  late TypeDialog dialog;

  @override
  void initState() {
    super.initState();
    context.read<ProductsInventoryListBloc>().add(ListProductModelEvent(listProductModel: widget.lstProductsModel));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ClickButtonSaveInventoryBloc>(create: (context) => ClickButtonSaveInventoryBloc()),
    ],
        child: BlocBuilder<InputAddAmountBloc, InputAddAmountState>(builder: (contextInputAmout, stateInputAmout) {
          if (stateInputAmout.id > 0) {
            ProductModel targetProduct = widget.lstProductsModel
                .firstWhere((product) => product.id == stateInputAmout.id);

            targetProduct.physicalInventory = stateInputAmout.amount;
            context.read<ProductsInventoryListBloc>().add(ListProductModelEvent(listProductModel: widget.lstProductsModel));
          }

          return BlocBuilder<ProductsInventoryListBloc, ProductsInventoryListState>(builder: (contextProductsInventory, stateProductsInventory){
            if (stateProductsInventory is ListProductModelState) {
              debugPrint("Entro al if");
              return BlocListener<ClickButtonSaveInventoryBloc, ClickButtonSaveInventoryState>(listener: (contextButtonSaveInventory, stateButtonSaveInventoryState){

                debugPrint("Entro listener ${stateButtonSaveInventoryState.onClick}");
                showAlert("Aviso", "Agrega por lo menos un regalo para continuar");
              },
                child: ListView.builder(
                  itemCount: stateProductsInventory.listProductModel!.length,
                  itemBuilder: (context, index) {
                    var currentProduct = stateProductsInventory.listProductModel![index];
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
                          visible: currentProduct.physicalInventory != 0 ? true : false,
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
                            child: Text(currentProduct.physicalInventory.toString(),
                              style: TextStyle(
                                  color: TColor.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
              );
            } else {
              return Container();
            }
          },
          );

        })
    );

  }

  void showError(String title, String description){
    dialog  = TypeDialog(context: context, title: title, description: description);
    dialog.showDialogError();

  }

  void showAlert(String title, String description){
    dialog  = TypeDialog(context: context, title: title, description: description);
    dialog.showDialogWarning();

  }

}
