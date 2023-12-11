import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/api/purchase_order_detail_bloc.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/api/purchase_order_detail_event.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/api/purchase_order_detail_state.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/barcode/order_barcode_bloc.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/lists/purchase_order_list_bloc.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/lists/purchase_order_list_state.dart';
import 'package:gomart/Menu/purchaseOrderDetail/repository/purchase_order_datail_repository.dart';
import 'package:intl/intl.dart';
import '../../../../Constants/app_colors.dart';
import '../../../../Helpers/get_color_hexadecimal.dart';
import '../../bloc/inputs/purchase_order_detail_inputs_bloc.dart';
import '../widgets/card_list_purchase_order_detail.dart';

class PurchaseOrderDetail extends StatefulWidget {
  final int purchaseOrderId;

  const PurchaseOrderDetail({super.key, required this.purchaseOrderId});

  @override
  State<PurchaseOrderDetail> createState() => _PurchaseOrderDetailState();
}

class _PurchaseOrderDetailState extends State<PurchaseOrderDetail> {
  late int total = 0;
  late double subTotal = 0;
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
                      purchaseOrderId: widget.purchaseOrderId)))
          ],
          child: BlocBuilder<PurchaseOrderDetailBloc, PurchaseOrderDetailState>(
              builder: (contextOrderDetail, stateOrderDetail) {
            if (stateOrderDetail.purchaseOrderDetailModel != null) {
              return Scaffold(
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
                  body: Stack(
                    children: [
                      CardListPurchaseOrderDetail(
                          lstPurchaseOrderDetail:
                              stateOrderDetail.purchaseOrderDetailModel!),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height/8,
                          width: MediaQuery.of(context).size.width,
                          color: Color(getColorHexadecimal(primaryColor)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: BlocBuilder<PurchaseOrderListBloc, PurchaseOrderListState>(builder: (contextSumOrders, stateSumOrders){
                            if(stateSumOrders.totalQuantity > 0){
                              total = total + stateSumOrders.totalQuantity;
                              subTotal = subTotal + stateSumOrders.subTotal;
                            }

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                        children:[
                                          Container(width: 80, alignment: Alignment.centerRight,child: const Text('CANTIDAD: ', style: TextStyle(color: Colors.white,),),),
                                          Text('$total',
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
                                          Container(width: 80, alignment: Alignment.centerRight, child: const Text('IEPS: ', style: TextStyle(color: Colors.white,),),),
                                          const Text('\$0.00', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),
                                        ]
                                    ),
                                    Row(children: [
                                      const Text('IVA: ', style: TextStyle(color: Colors.white),),
                                      Container(width: 90, alignment: Alignment.centerRight,
                                        child: const Text('\$0.00', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),),

                                    ])
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Text('TOTAL: ', style: TextStyle(color: Colors.white),),
                                      Container(width: 90, alignment: Alignment.centerRight,
                                        child: const Text('\$0.00', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),),
                                    ],
                                  ),
                                )
                              ],
                            );
                          }),
                      ))
                    ],
                  ));
            }
            return const CircularProgressIndicator();
          })),
    );
  }

  String formatCurrency(double amount) {
    // use 'es_US' si prefieres el formato en dólares
    final currencyFormat = NumberFormat.currency(locale: 'es_MX', symbol: '\$');
    return currencyFormat.format(amount);
  }
}
