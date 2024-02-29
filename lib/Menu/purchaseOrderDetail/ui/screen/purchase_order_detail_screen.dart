import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/api/purchase_order_detail_bloc.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/api/purchase_order_detail_event.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/api/purchase_order_detail_state.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/barcode/order_barcode_bloc.dart';
import 'package:gomart/Menu/purchaseOrderDetail/repository/purchase_order_datail_repository.dart';
import 'package:intl/intl.dart';
import '../../../../Constants/app_colors.dart';
import '../../../../Helpers/dialogs/type_dialog.dart';
import '../../../../Helpers/get_color_hexadecimal.dart';
import '../../../purchaseOrder/models/reference_order_model.dart';
import '../../bloc/api/reception/reception_bloc.dart';
import '../../bloc/api/reception/reception_event.dart';
import '../../bloc/inputs/purchase_order_detail_inputs_bloc.dart';
import '../../bloc/reception/purchase_order_list_bloc.dart';
import '../../bloc/reception/purchase_order_list_state.dart';
import '../widgets/card_list_purchase_order_detail.dart';

class PurchaseOrderDetailScreen extends StatefulWidget {
  final ReferenceOrderModel referenceOrderModel;

  const PurchaseOrderDetailScreen({super.key, required this.referenceOrderModel});

  @override
  State<PurchaseOrderDetailScreen> createState() => _PurchaseOrderDetailState();
}

class _PurchaseOrderDetailState extends State<PurchaseOrderDetailScreen> {
  late int totalQuantity = 0;
  late double subTotal = 0;
  late double iva = 0;
  late double ieps = 0;
  late double total = 0;
  //late double discount = 0;
  late TypeDialog dialog;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PurchaseOrderDetailRepository(),
      child: MultiBlocProvider(
          providers: [
            BlocProvider<PurchaseOrderListBloc>(
                create: (context) => PurchaseOrderListBloc()),
            BlocProvider<OrderBarcodeBloc>(
              create: (context) => OrderBarcodeBloc(),
            ),
            BlocProvider<PurchaseOrderDatailInputsBloc>(
              create: (context) => PurchaseOrderDatailInputsBloc(),
            ),
            BlocProvider<PurchaseOrderDetailBloc>(
                create: (context) => PurchaseOrderDetailBloc(
                    RepositoryProvider.of<PurchaseOrderDetailRepository>(
                        context))
                  ..add(LoadOrderDetailEvent(
                      purchaseOrderId: widget.referenceOrderModel.orderId))),
            BlocProvider<ReceptionBloc>(create: (context) =>
            ReceptionBloc(RepositoryProvider.of<PurchaseOrderDetailRepository>(context))..add(UpdateIsBusyEvent(purchaseOrderId: widget.referenceOrderModel.orderId,)))
          ],
          child: BlocListener<PurchaseOrderDetailBloc, PurchaseOrderDetailState>(listener: (contextOrderDetail, stateOrderDetail){
            if (stateOrderDetail is ErrorPurchaseOrderDetail){
              //debugPrint("desde ordenes ${statePurchase.errorApi}");
              messagesSnackBar(stateOrderDetail.errorApi);
              onBack();
            }

          }, child: BlocBuilder<PurchaseOrderDetailBloc, PurchaseOrderDetailState>(
              builder: (contextOrderDetail, stateOrderDetail) {
            if (stateOrderDetail.receptionDetail != null) {
              return PopScope(
                canPop: false,
                  onPopInvoked: (bool didPop){
                    if (didPop) {
                      return;
                    }
                    showDialogQuestion("¿Estas seguro de regresar?","Perderas el avance de la recepcion",contextOrderDetail);
                  },
                  child: Scaffold(
                      appBar: AppBar(
                        title: Text(
                          "Recepción de orden",
                          style: TextStyle(
                              color: Color(getColorHexadecimal(secondaryColor))),
                        ),
                        iconTheme: IconThemeData(
                            color: Color(getColorHexadecimal(secondaryColor))),
                        backgroundColor: Color(getColorHexadecimal(primaryColor)),
                      ),
                      body: Column(
                        children: [
                          Expanded(
                            child: CardListPurchaseOrderDetail(
                              lstReceptionDetail: stateOrderDetail.receptionDetail!,
                              referenceOrderModel: widget.referenceOrderModel,
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 8,
                            width: MediaQuery.of(context).size.width,
                            color: Color(getColorHexadecimal(primaryColor)),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: BlocBuilder<PurchaseOrderListBloc, PurchaseOrderListState>(
                              builder: (contextSumOrders, stateSumOrders) {
                                if(stateSumOrders.totalQuantity > 0){
                                  totalQuantity += stateSumOrders.totalQuantity;
                                  subTotal += stateSumOrders.subTotal;
                                  iva += stateSumOrders.iva;
                                  ieps += stateSumOrders.ieps;
                                  //discount += stateSumOrders.discount;
                                  total = subTotal + iva + ieps; //- discount;
                                }

                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                            children:[
                                              Container(width: 80, alignment: Alignment.centerRight,child: const Text('IEPS: ', style: TextStyle(color: Colors.white,),),),
                                              Text(formatCurrency(ieps),
                                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),
                                            ]
                                        ),
                                        Row(children: [
                                          const Text('SUBTOTAL: ', style: TextStyle(color: Colors.white),),
                                          Container(width: 90, alignment: Alignment.centerRight,
                                            child: Text(formatCurrency(subTotal), style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),),
                                        ])
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                            children:[
                                              Container(width: 80, alignment: Alignment.centerRight, child: const Text('IVA: ', style: TextStyle(color: Colors.white,),),),
                                              Text(formatCurrency(iva), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),
                                            ]
                                        ),
                                        Row(children: [
                                          const Text('TOTAL: ', style: TextStyle(color: Colors.white),),
                                          Container(width: 90, alignment: Alignment.centerRight,
                                            child: Text(formatCurrency(total), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),),

                                        ])
                                      ],
                                    ),
                                    // Align(
                                    //   alignment: Alignment.center,
                                    //   child: Row(
                                    //     mainAxisAlignment: MainAxisAlignment.end,
                                    //     children: [
                                    //       const Text('TOTAL: ', style: TextStyle(color: Colors.white),),
                                    //       Container(width: 90, alignment: Alignment.centerRight,
                                    //         child: Text(formatCurrency(total), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                  )
              );
            }
            return const CircularProgressIndicator();
          })
      ),
    )
    );
  }

  String formatCurrency(double amount) {
    // use 'es_US' si prefieres el formato en dólares
    final currencyFormat = NumberFormat.currency(locale: 'es_MX', symbol: '\$');
    return currencyFormat.format(amount);
  }
  String formatCurrencyDiscount(double amount) {
    // use 'es_US' si prefieres el formato en dólares
    final currencyFormat = NumberFormat.currency(locale: 'es_MX', symbol: '-\$');
    return currencyFormat.format(amount);
  }

  void messagesSnackBar(String message){
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showDialogQuestion(String title, String description, BuildContext contextOrderDetail){
    dialog = TypeDialog(
        context: context,
        title: title,
        description: description,
        onCancel: (){

        },
        onOk: (){
          contextOrderDetail.read<ReceptionBloc>().add(UpdateIsBusyEvent(purchaseOrderId: widget.referenceOrderModel.orderId,));
          closingDialog();
        }
    );
    dialog.showDialogQuestion("Aceptar","Cancelar");

  }

  void closingDialog(){
    Navigator.pop(context);
  }
  void onBack(){
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // const snackBar = SnackBar(
    //   content: Text("La aplicación se está cerrando"),
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    super.dispose();
  }
}
