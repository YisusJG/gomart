import 'package:flutter/material.dart';
import '../../models/purchase_order_model.dart';
import 'card_purchase_order.dart';

class CardListPurchaseOrders extends StatefulWidget {
  final List<PurchaseOrderModel> purchaseOrderModel;
  const CardListPurchaseOrders({super.key, required this.purchaseOrderModel});

  @override
  State<CardListPurchaseOrders> createState() => _CardListPurchaseOrdersState();
}

class _CardListPurchaseOrdersState extends State<CardListPurchaseOrders> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.purchaseOrderModel.length,
        itemBuilder: (context,index) {
          return SizedBox(
            height: MediaQuery.of(context).size.height/2.8,
            child: CardPurchaseOrder(purchaseOrderModel: widget.purchaseOrderModel, index: index,),
          );
        }
    );
  }
}
