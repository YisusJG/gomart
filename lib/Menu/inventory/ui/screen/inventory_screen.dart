import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/api/branchInventory/branch_inventory_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/api/branchInventory/branch_inventory_event.dart';
import 'package:gomart/Menu/inventory/bloc/api/branchInventory/branch_inventory_state.dart';
import 'package:gomart/Menu/inventory/bloc/api/productCategories/product_categories_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/api/productCategories/product_cetegories_event.dart';
import 'package:gomart/Menu/inventory/bloc/api/productCategories/product_categories_state.dart';
import 'package:gomart/Menu/inventory/bloc/api/productsByCategory/products_by_category_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/api/productsByCategory/products_by_category_event.dart';
import 'package:gomart/Menu/inventory/bloc/buttonSaveInventory/click_button_save_inventory_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/buttonSaveInventory/click_button_save_inventory_event.dart';
import 'package:gomart/Menu/inventory/bloc/buttonSaveInventory/click_button_save_inventory_state.dart';
import 'package:gomart/Menu/inventory/bloc/input/input_add_amount_bloc.dart';
import 'package:gomart/Menu/inventory/model/branch_inventory_model.dart';
import 'package:gomart/Menu/inventory/model/branch_inventory_product_model.dart';
import 'package:gomart/Menu/inventory/model/product_category_model.dart';
import 'package:gomart/Menu/inventory/repository/inventory_repository.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:gomart/Menu/inventory/ui/widget/card_list_products_by_category.dart';
import '../../../../Constants/app_colors.dart';
import '../../../../Helpers/dialogs/type_dialog.dart';
import '../../../../Helpers/get_color_hexadecimal.dart';
import '../../../../Helpers/scan_barcode_channel.dart';
import '../../../purchaseOrderDetail/bloc/barcode/order_barcode_bloc.dart';
import '../../../purchaseOrderDetail/bloc/barcode/order_barcode_event.dart';
import '../../../purchaseOrderDetail/bloc/barcode/order_barcode_state.dart';
import '../../bloc/api/productsByCategory/products_by_category_state.dart';
import '../../bloc/barcode/inventory_barcode_bloc.dart';
import '../../bloc/input/input_add_amount_event.dart';
import '../../bloc/input/input_add_amount_state.dart';
import '../../bloc/list/products_inventory_list_bloc.dart';
import '../../bloc/list/products_inventory_list_event.dart';
import '../../bloc/list/products_inventory_list_state.dart';
import '../../model/branch_inventory_id.dart';
import '../../model/product_model.dart';
import '../widget/card_list_products_by_category_detail.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  var categoryId = 0;
  var previousId = 0;
  var visibleAmount = false;
  //var previousValue = "";
  ProductCategoryModel? _selectedProductCategory;

  @override
  Widget build(BuildContext context) {
    List<ProductModel>? listProductModel;
    return RepositoryProvider(
      create: (context) => InventoryRepository(),
      child: MultiBlocProvider(
          providers: [
            BlocProvider<ProductCategoriesBloc>(
                create: (context) => ProductCategoriesBloc(
                    RepositoryProvider.of<InventoryRepository>(context)
                )
                  ..add(LoadProductCategoriesEvent())
            ),
            BlocProvider<ProductsByCategoryBloc>(
                create: (context) => ProductsByCategoryBloc(
                    RepositoryProvider.of<InventoryRepository>(context)
                )
            ),
            BlocProvider<InventoryBarcodeBloc>(
              create: (context) => InventoryBarcodeBloc(),
            ),
            BlocProvider<InputAddAmountBloc>(
              create: (context) => InputAddAmountBloc(),
            ),
            BlocProvider<ProductsInventoryListBloc>(
                create: (context) => ProductsInventoryListBloc()
            ),
            BlocProvider<ClickButtonSaveInventoryBloc>(
                create: (context) => ClickButtonSaveInventoryBloc(),
            ),
          ],
          child: BlocBuilder<ProductCategoriesBloc, ProductCategoriesState>(
              builder: (contextInventory, stateInventory) {
            if (stateInventory.productCategoryModel != null) {
              return BlocBuilder<ClickButtonSaveInventoryBloc, ClickButtonSaveInventoryState>(builder: (contextClick, stateClick){
                return Scaffold(
                    appBar: AppBar(
                      title: Text(
                        "Inventario",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(getColorHexadecimal(secondaryColor))),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: IconButton(
                              onPressed: () {
                                //BlocProvider.of<ClickButtonSaveInventoryBloc>(contextInventory).add(ButtonSaveInventoryEvent());
                                contextInventory.read<ClickButtonSaveInventoryBloc>().add(ButtonSaveInventoryEvent());
                              },
                              icon: const Icon(
                                Icons.save_sharp,
                                color: Colors.white,
                                size: 30,
                              )
                          ),
                        )
                      ],
                      iconTheme: IconThemeData(
                          color: Color(getColorHexadecimal(secondaryColor))),
                      backgroundColor: Color(getColorHexadecimal(primaryColor)),
                    ),
                    body: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: BlocBuilder<ProductsInventoryListBloc,ProductsInventoryListState>(builder: (contextProductsInventory,stateProductsInventory) {
                            listProductModel = stateProductsInventory.listProductModel;
                            /*if (listProductModel != null) {
                              listProductModel?.forEach((product) {
                                print(
                                    "${product.name} : ${product.physicalInventory}");
                              });
                            }*/
                            return DropdownSearch<ProductCategoryModel>(
                                selectedItem: _selectedProductCategory,
                                popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    showSelectedItems: false,
                                    searchFieldProps: TextFieldProps(
                                        decoration: InputDecoration(
                                          hintText: "Buscar categoria",
                                          hintStyle: TextStyle(color: Colors.grey),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide:
                                            BorderSide(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ))),
                                items: stateInventory.productCategoryModel!,
                                itemAsString: (ProductCategoryModel u) => u.name,
                                onChanged: (ProductCategoryModel? value) {
                                  print(value?.toJson());
                                  /*setState(() {
                                  _selectedProductCategory = value;
                                });

                                print(
                                    "El selected es ${_selectedProductCategory?.toJson()}");*/

                                  if (_selectedProductCategory == null) {
                                    setState(() {
                                      //categoryId = value!.id;
                                      //previousValue = value.name;
                                      _selectedProductCategory = value;
                                    });
                                  } else {
                                    if (listProductModel != null) {
                                      if (listProductModel!.any((product) => product.physicalInventory != 0)) {
                                        showDialogConfirm(
                                            title: "Ya tienes productos en tu inventario",
                                            description: "Se borraran los productos inventariados",
                                            onOK: (){
                                              print("En el ok es ${_selectedProductCategory?.toJson()}");
                                              //previousValue = value!.name;
                                              //categoryId = value.id;
                                              listProductModel?.clear();
                                              contextProductsInventory.read<ProductsInventoryListBloc>().add(ListProductModelEvent(listProductModel: null));
                                              contextProductsInventory.read<InputAddAmountBloc>().add(InputAmountEvent(amount: 0, id: 0));
                                              setState(() {
                                                _selectedProductCategory = value;
                                              });
                                              print("Antes del clear es ${listProductModel?.length}");

                                              //print("Despues del clear es ${listProductModel?.length}");


                                            },
                                            onCancel: (){
                                              print("En el cancel es ${_selectedProductCategory?.toJson()}");
                                              setState(() {
                                                //value!.name = previousValue;
                                                value = _selectedProductCategory;
                                              });
                                            });
                                      } else {
                                        setState(() {
                                          //categoryId = value!.id;
                                          //previousValue = value.name;
                                          _selectedProductCategory = value;
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        //categoryId = value!.id;
                                        //previousValue = value.name;
                                        _selectedProductCategory == value;
                                      });
                                    }
                                  }
                                },
                                // print,
                                //(ProductCategoryModel? data) => print(data?.name),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    labelText: "Seleccion una Categoria",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ));
                            /*return DropdownSearch<ProductCategoryModel>(
                              selectedItem: _selectedProductCategory,
                              popupProps: PopupProps.menu(
                                  showSearchBox: true,
                                  showSelectedItems: false,
                                  searchFieldProps: TextFieldProps(
                                      decoration: InputDecoration(
                                        hintText: "Buscar categoria",
                                        hintStyle: TextStyle(color: Colors.grey),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ))),
                              items: stateInventory.productCategoryModel!,
                              itemAsString: (ProductCategoryModel u) => u.name,
                              onChanged: (ProductCategoryModel? value) {
                                print(value?.toJson());
                                /*setState(() {
                                  _selectedProductCategory = value;
                                });

                                print(
                                    "El selected es ${_selectedProductCategory?.toJson()}");*/

                                if (_selectedProductCategory == null) {
                                  setState(() {
                                    //categoryId = value!.id;
                                    //previousValue = value.name;
                                    _selectedProductCategory = value;
                                  });
                                } else {
                                  if (listProductModel != null) {
                                    if (listProductModel!.any((product) => product.physicalInventory != 0)) {
                                      showDialogConfirm(
                                          title: "Ya tienes productos en tu inventario",
                                          description: "Se borraran los productos inventariados",
                                          onOK: (){
                                            print("En el ok es ${_selectedProductCategory?.toJson()}");
                                            //previousValue = value!.name;
                                            //categoryId = value.id;
                                            listProductModel?.clear();
                                            contextProductsInventory.read<ProductsInventoryListBloc>().add(ListProductModelEvent(listProductModel: null));
                                            //context.read<InputAddAmountBloc>().add(InputAmountEvent(id: 0, amount: 0));
                                            //setState(() {
                                                _selectedProductCategory = value;
                                            //  });
                                            print("Antes del clear es ${listProductModel?.length}");

                                            //print("Despues del clear es ${listProductModel?.length}");


                                          },
                                          onCancel: (){
                                            print("En el cancel es ${_selectedProductCategory?.toJson()}");
                                            setState(() {
                                              //value!.name = previousValue;
                                              value = _selectedProductCategory;
                                            });
                                          });
                                    } else {
                                      setState(() {
                                        //categoryId = value!.id;
                                        //previousValue = value.name;
                                        _selectedProductCategory = value;
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      //categoryId = value!.id;
                                      //previousValue = value.name;
                                      _selectedProductCategory == value;
                                    });
                                  }
                                }
                              },
                              // print,
                              //(ProductCategoryModel? data) => print(data?.name),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "Seleccion una Categoria",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ));*/
                          }),
                        ),

                        const SizedBox(
                          height: 5,
                        ),
                        if (_selectedProductCategory != null)
                          CardListProductsByCategory(selectedProductCategory: _selectedProductCategory!),

                      ],
                    ));
              });

            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          })),
    );
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

  void messagesSnackBar(String message){
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
