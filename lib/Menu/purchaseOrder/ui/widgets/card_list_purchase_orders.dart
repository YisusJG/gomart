import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/api/order/purchase_order_bloc.dart';
import '../../bloc/api/order/purchase_order_state.dart';
import 'card_purchase_order.dart';

class CardListPurchaseOrders extends StatefulWidget {
  const CardListPurchaseOrders({super.key});

  @override
  State<CardListPurchaseOrders> createState() => _CardListPurchaseOrdersState();
}

class _CardListPurchaseOrdersState extends State<CardListPurchaseOrders> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PurchaseOrderBloc, PurchaseOrderState>(builder: (contextPurchaseOrder, statePurchaseOrder){
      return ListView.builder(
          itemCount: statePurchaseOrder.purchaseOrderModel!.length,
          itemBuilder: (context,index) {
            return SizedBox(
              height: MediaQuery.of(context).size.height/2.8,
              child: CardPurchaseOrder(purchaseOrderModel: statePurchaseOrder.purchaseOrderModel!, index: index,),
            );
          }
      );
    });
  }
}
