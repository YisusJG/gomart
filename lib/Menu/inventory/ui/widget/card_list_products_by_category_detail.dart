import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/api/branchInventory/branch_inventory_state.dart';
import 'package:gomart/Menu/inventory/bloc/buttonSaveInventory/click_button_save_inventory_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/buttonSaveInventory/click_button_save_inventory_state.dart';
import 'package:gomart/Menu/inventory/bloc/input/input_add_amount_event.dart';
import '../../../../Constants/app_colors.dart';
import '../../../../Helpers/dialogs/type_dialog.dart';
import '../../../../Helpers/get_color_hexadecimal.dart';
import '../../bloc/api/branchInventory/branch_inventory_bloc.dart';
import '../../bloc/api/branchInventory/branch_inventory_event.dart';
import '../../bloc/input/input_add_amount_bloc.dart';
import '../../bloc/input/input_add_amount_state.dart';
import '../../bloc/list/products_inventory_list_bloc.dart';
import '../../bloc/list/products_inventory_list_event.dart';
import '../../model/branch_inventory_model.dart';
import '../../model/branch_inventory_product_model.dart';
import '../../model/product_category_model.dart';
import '../../model/product_model.dart';

class CardListProductsByCategoryDetail extends StatefulWidget {
  final List<ProductModel> lstProductsModel;
  final ProductCategoryModel selectedProductCategory;

  const CardListProductsByCategoryDetail(
      {super.key,
      required this.lstProductsModel,
      required this.selectedProductCategory});

  @override
  State<CardListProductsByCategoryDetail> createState() =>
      _CardListProductsByCategoryDetailState();
}

class _CardListProductsByCategoryDetailState
    extends State<CardListProductsByCategoryDetail> {
  late TypeDialog dialog;

  @override
  void initState() {
    super.initState();
    context.read<ProductsInventoryListBloc>().add(ListProductModelEvent(listProductModel: widget.lstProductsModel));
  }

  @override
  Widget build(BuildContext context) {
    var branchNumber = "";
    var branchId = 0;
    var insertUserId = 0;

    return MultiBlocProvider(providers:[
    BlocProvider<BranchInventoryBloc>(create: (context) => BranchInventoryBloc(RepositoryProvider.of(context))),

    ],
      child: BlocListener<ClickButtonSaveInventoryBloc,ClickButtonSaveInventoryState>(
        listener: (contextButtonSaveInventory, stateButtonSaveInventoryState) {
        debugPrint("El tamaño de lista es ${widget.lstProductsModel.length}");
        var amountInventoryProduct = widget.lstProductsModel.any((element) => element.physicalInventory != 0);
        if (amountInventoryProduct == false) {
          messagesSnackBar("No existe un inventario para guardar");
        } else {
          showDialogConfirm(
              title: "¿Deseas guardar el inventario?",
              description:
              "No podras modificar el inventario",
              onOK: () {
                contextButtonSaveInventory.read<BranchInventoryBloc>().add(GetBranchInventoryEvent(branchModel: null));
              },
              onCancel: () {

              });
        }
    }, child: BlocListener<BranchInventoryBloc, BranchInventoryState>(listener: (contextBranchId, stateBranchId){
        debugPrint("el id es ${stateBranchId.branchInventoryId?.branchInventoryId}");

        if (stateBranchId is GetBranchInventoryState) {
          branchNumber = stateBranchId.branchModel!.branchNumber;
          contextBranchId.read<BranchInventoryBloc>().add(GetEmployeeInfoEvent(employeeModel: null));
        }

        if (stateBranchId is GetEmployeeInfoState) {
          branchId = stateBranchId.employeeModel!.branchId;
          insertUserId = stateBranchId.employeeModel!.id;
          BranchInventoryModel branchInventoryModel = BranchInventoryModel(name: branchNumber, productCategoryId: widget.selectedProductCategory.id, branchId:  branchId, insertUserId: insertUserId );
          contextBranchId.read<BranchInventoryBloc>().add(SaveBranchInventoryEvent(branchInventoryModel: branchInventoryModel));
        }

        if (stateBranchId is SaveBranchInventoryState) {
          List<BranchInventoryProductModel> branchInventoryProductModelList = [];
          for (var element in widget.lstProductsModel) {
            BranchInventoryProductModel branchInventoryProductModel = BranchInventoryProductModel(
                branchInventoriesId: stateBranchId.branchInventoryId!.branchInventoryId,
                branchId: branchId,
                productId: element.id,
                count: element.physicalInventory,
                visible: true,
                insertUserId: insertUserId
            );
            branchInventoryProductModelList.add(branchInventoryProductModel);
          }
          contextBranchId.read<BranchInventoryBloc>().add(SaveBranchInventoryProductEvent(branchInventoryProductModel: branchInventoryProductModelList));
          widget.lstProductsModel.clear();
          contextBranchId.read<InputAddAmountBloc>().add(InputAmountEvent(amount: 0, id: 0));
        }

      },
      child: BlocBuilder<InputAddAmountBloc, InputAddAmountState>(
          builder: (contextInputAmout, stateInputAmout) {
            if (stateInputAmout.id > 0) {
              ProductModel targetProduct = widget.lstProductsModel
                  .firstWhere((product) => product.id == stateInputAmout.id);

              targetProduct.physicalInventory = stateInputAmout.amount;
              context.read<ProductsInventoryListBloc>().add(
                  ListProductModelEvent(listProductModel: widget.lstProductsModel));
            }
            return ListView.builder(
                itemCount: widget.lstProductsModel.length,
                itemBuilder: (context, index) {
                  var currentProduct = widget.lstProductsModel[index];
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
                });
          })),


    ));
  }

  void showError(String title, String description) {
    dialog =
        TypeDialog(context: context, title: title, description: description);
    dialog.showDialogError();
  }

  void showAlert(String title, String description) {
    dialog =
        TypeDialog(context: context, title: title, description: description);
    dialog.showDialogWarning();
  }

  void messagesSnackBar(String message){
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showDialogConfirm(
      {required String title,
        required String description,
        VoidCallback? onOK,
        VoidCallback? onCancel}) {
    TypeDialog dialog = TypeDialog(
        context: context,
        title: title,
        description: description,
        onOk: onOK,
        onCancel: onCancel);
    dialog.showDialogConfirm();
  }
}
