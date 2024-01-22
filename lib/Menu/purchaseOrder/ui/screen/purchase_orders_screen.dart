import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/purchaseOrder/bloc/api/catDocumentReception/cat_type_document_reception_bloc.dart';
import 'package:gomart/Menu/purchaseOrder/bloc/api/catDocumentReception/cat_type_document_reception_event.dart';
import 'package:gomart/Menu/purchaseOrder/bloc/api/order/purchase_order_bloc.dart';
import 'package:gomart/Menu/purchaseOrder/bloc/api/order/purchase_order_event.dart';
import 'package:gomart/Menu/purchaseOrder/bloc/api/order/purchase_order_state.dart';
import 'package:gomart/Menu/purchaseOrder/repository/purchase_order_repository.dart';
import '../../../../Constants/app_colors.dart';
import '../../../../Helpers/dialogs/type_dialog.dart';
import '../../../../Helpers/get_color_hexadecimal.dart';
import '../../bloc/api/cancel/purchase_order_cancel_bloc.dart';
import '../widgets/card_list_purchase_orders.dart';

class PurchaseOrdersScreen extends StatefulWidget {
  const PurchaseOrdersScreen({super.key});

  @override
  State<PurchaseOrdersScreen> createState() => _PurchaseOrdersScreenState();
}

class _PurchaseOrdersScreenState extends State<PurchaseOrdersScreen> {
  late TypeDialog genericDialog;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PurchaseOrderRepository(),
      child: MultiBlocProvider(
          providers: [
            BlocProvider<CatTypeDocumentReceptionBloc>(create: (context) => CatTypeDocumentReceptionBloc(RepositoryProvider.of<PurchaseOrderRepository>(context))..add(LoadDocumentReception())),
            BlocProvider<PurchaseOrderBloc>(create: (context) => PurchaseOrderBloc(RepositoryProvider.of<PurchaseOrderRepository>(context))..add(LoadPurchaseOrdersEvent())),
            BlocProvider<PurchaseOrderCancelBloc>(create: (context) => PurchaseOrderCancelBloc(RepositoryProvider.of<PurchaseOrderRepository>(context)))
          ],
          child: BlocBuilder<PurchaseOrderBloc, PurchaseOrderState>(builder: (contextPurchaseOrder, statePurchaseOrder) {
            if(statePurchaseOrder.purchaseOrderModel != null){ //Descomentar este if para cuando quieras pintar un loading
              //closingDialog();
              return Scaffold(
                appBar: AppBar(
                  title:  Text("Ordeness de compra",style: TextStyle(color: Color(getColorHexadecimal(secondaryColor))),),
                  iconTheme: IconThemeData(color: Color(getColorHexadecimal(secondaryColor))),
                  backgroundColor: Color(getColorHexadecimal(primaryColor)),
                ),
                body: Stack(
                  children: [
                    CardListPurchaseOrders(purchaseOrderModel: statePurchaseOrder.purchaseOrderModel!,),
                  ],
                ),
              );
            }
           // showDialogUpluading("Cargando ordenes de compra");
            //return const Placeholder();
            return const CircularProgressIndicator();

          })
      ),
    );
  }

  void showDialogUpluading(String description){
    genericDialog = TypeDialog(
        context: context,
        description:description
    );
    genericDialog.showDialogUploading();
  }

  void closingDialog(){
    Navigator.pop(context);
  }
}
