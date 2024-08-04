import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Constants/app_colors.dart';
import 'package:gomart/Helpers/dialogs/type_dialog.dart';
import 'package:gomart/Helpers/get_color_hexadecimal.dart';
import 'package:gomart/Menu/home/ui/screen/home_screen.dart';
import 'package:gomart/Menu/inventory/bloc/api/branchInventory/branch_inventory_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/api/branchInventory/branch_inventory_event.dart';
import 'package:gomart/Menu/inventory/bloc/api/cyclicalInventories/cyclical_inventories_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/api/cyclicalInventories/cyclical_inventories_event.dart';
import 'package:gomart/Menu/inventory/bloc/api/cyclicalInventories/cyclical_inventories_state.dart';
import 'package:gomart/Menu/inventory/bloc/input/input_add_amount_bloc.dart';
import 'package:gomart/Menu/inventory/repository/inventory_repository.dart';
import 'package:gomart/Menu/inventory/ui/widget/card_list_products_cyclical_inventory.dart';

class ProductCyclicalInventoryScreen extends StatefulWidget {
  final int cyclicalInventoryId;
  const ProductCyclicalInventoryScreen({super.key, required this.cyclicalInventoryId});

  @override
  State<ProductCyclicalInventoryScreen> createState() => _ProductCyclicalInventoryScreenState();
}

class _ProductCyclicalInventoryScreenState extends State<ProductCyclicalInventoryScreen> {
  late TypeDialog dialog;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => InventoryRepository(),
      child: MultiBlocProvider(
          providers: [
            BlocProvider<CyclicalInventoriesBloc>(
              create: (context) => CyclicalInventoriesBloc(
                RepositoryProvider.of<InventoryRepository>(context),
              )..add(LoadProductsCyclicalInventoryEvent(cyclicalInventoryId: widget.cyclicalInventoryId)),
            ),
            BlocProvider<InputAddAmountBloc>(
              create: (context) => InputAddAmountBloc(),
            ),
            BlocProvider<BranchInventoryBloc>(
              create: (context) => BranchInventoryBloc(RepositoryProvider.of(context)),
            ),
          ],

          child: BlocListener<CyclicalInventoriesBloc, CyclicalInventoriesState>(
            listener: (contextProductsCyclicalInventory, stateProductsCyclicalInventory) {
              if (stateProductsCyclicalInventory is ErrorCyclicalInventoriesState) {
                messagesSnackBar(stateProductsCyclicalInventory.errorApi);
              }
            },
            child: BlocBuilder<CyclicalInventoriesBloc, CyclicalInventoriesState>(
              builder: (contextProductsCyclicalInventory, stateProductsCyclicalInventory) {
                return PopScope(
                  canPop: false,
                  onPopInvoked: (bool didPop) {
                    if (didPop) {
                      return;
                    }
                    final productsState = contextProductsCyclicalInventory.read<CyclicalInventoriesBloc>().state;
                    final productCount = productsState.cyclicalInventoryProductModel?.any((product) => product.count != 0);
                    if (productCount == true) {
                      showDialogQuestion("¿Estas seguro de regresar?","Perderas el avance del inventario");
                    } else {
                      Navigator.of(context).pop();
                    }

                  },
                  child: Scaffold(
                    appBar: AppBar(
                      iconTheme: IconThemeData(
                        color: Color(getColorHexadecimal(secondaryColor)),
                      ),
                      backgroundColor: Color(getColorHexadecimal(primaryColor)),
                      title: Text(
                        "Productos",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(getColorHexadecimal(secondaryColor)),
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: IconButton(
                              onPressed: () {
                                final productsState = contextProductsCyclicalInventory.read<CyclicalInventoriesBloc>().state;
                                final productCount = productsState.cyclicalInventoryProductModel?.any((product) => product.count != 0);
                                if (productCount == true) {
                                  showDialogConfirm(
                                      title: "¿Deseas guardar el inventario?",
                                      description:
                                      "No podras modificar el inventario",
                                      onOK: () {
                                        contextProductsCyclicalInventory.read<BranchInventoryBloc>().add(GetBranchInventoryEvent(branchModel: null));

                                        //showDialogSucces("Guardado exitoso", stateSaveBranchInventory.message);
                                        //showDialogSucces("Guardado exitoso", "Prueba");
                                      },
                                      onCancel: () {

                                      });
                                } else {
                                  messagesSnackBar("No existe un inventario para guardar");
                                }
                              },
                              icon: const Icon(
                                Icons.save_sharp,
                                color: Colors.white,
                                size: 30,
                              )
                          ),
                        )
                      ],
                    ),
                    body: _buildBody(stateProductsCyclicalInventory),
                  ),
                );
              },
            ),
          ),
      )
    );
  }

  Widget _buildBody(CyclicalInventoriesState stateProductsCyclicalInventory) {
    if (stateProductsCyclicalInventory is StartProductsCyclicalInventoryState) {
      return const Center(child: CircularProgressIndicator());
    } else if (stateProductsCyclicalInventory is LoadProductsCyclicalInventoryState) {
      if (stateProductsCyclicalInventory.cyclicalInventoryProductModel != null && stateProductsCyclicalInventory.cyclicalInventoryProductModel!.isNotEmpty) {
        return Center(
          child: CardListProductsCyclicalInventory(
            listCyclicalInventoryModel: stateProductsCyclicalInventory.cyclicalInventoryProductModel!,
          ),
        );
      } else {
        return const Center(child: Text("No se encontraron datos."));
      }
    } else {
      return const Center(child: Text("Estado desconocido."));
    }
  }

  void showDialogQuestion(String title, String description) {
    dialog = TypeDialog(
      context: context,
      title: title,
      description: description,
      onCancel: () {},
      onOk: () {
        onBack();
      },
    );
    dialog.showDialogQuestion("Aceptar", "Cancelar");
  }

  void onBack() {
    Navigator.pop(context);
  }

  void messagesSnackBar(String message) {
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

  void showDialogSucces(String title, String description) {
    dialog = TypeDialog(
        context: context,
        title: title,
        description: description,
        onOk: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
    );
    dialog.showDialogSucces();
  }
}
