import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/api/cyclicalInventories/cyclical_inventories_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/api/cyclicalInventories/cyclical_inventories_event.dart';
import 'package:gomart/Menu/inventory/bloc/api/cyclicalInventories/cyclical_inventories_state.dart';
import 'package:gomart/Menu/inventory/repository/inventory_repository.dart';
import 'package:gomart/Menu/inventory/ui/widget/card_list_cyclical_inventory.dart';

import '../../../../Constants/app_colors.dart';
import '../../../../Helpers/dialogs/type_dialog.dart';
import '../../../../Helpers/get_color_hexadecimal.dart';

class CyclicalInventoryScreen extends StatefulWidget {
  const CyclicalInventoryScreen({super.key});

  @override
  State<CyclicalInventoryScreen> createState() => _CyclicalInventoryScreenState();
}

class _CyclicalInventoryScreenState extends State<CyclicalInventoryScreen> {
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
            )..add(LoadCyclicalInventoriesEvent()),
          ),
        ],
        child: BlocListener<CyclicalInventoriesBloc, CyclicalInventoriesState>(
          listener: (contextCyclicalInventory, stateCyclicalInventory) {
            if (stateCyclicalInventory is ErrorCyclicalInventoriesState) {
              debugPrint("Error");
              messagesSnackBar(stateCyclicalInventory.errorApi);
              onBack();
            }
          },
          child: BlocBuilder<CyclicalInventoriesBloc, CyclicalInventoriesState>(
            builder: (contextCyclicalInventory, stateCyclicalInventory) {
              return PopScope(
                canPop: true,
                child: Scaffold(
                  appBar: AppBar(
                    iconTheme: IconThemeData(
                      color: Color(getColorHexadecimal(secondaryColor)),
                    ),
                    backgroundColor: Color(getColorHexadecimal(primaryColor)),
                    title: Text(
                      "Inventarios Ciclicos",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(getColorHexadecimal(secondaryColor)),
                      ),
                    ),
                  ),
                  body: _buildBody(stateCyclicalInventory),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(CyclicalInventoriesState stateCyclicalInventory) {
    if (stateCyclicalInventory is StartCyclicalInventoriesState) {
      return const Center(child: CircularProgressIndicator());
    } else if (stateCyclicalInventory is LoadCyclicalInventoriesState) {
      if (stateCyclicalInventory.cyclicalInventoryModel != null && stateCyclicalInventory.cyclicalInventoryModel!.isNotEmpty) {
        return Center(
          child: CardListCyclicalInventory(
            listCyclicalInventoryModel: stateCyclicalInventory.cyclicalInventoryModel,
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
}
