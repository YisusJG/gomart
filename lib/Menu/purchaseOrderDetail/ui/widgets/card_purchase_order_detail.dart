import 'package:flutter/material.dart';
import 'package:gomart/Helpers/dialogs/type_dialog.dart';
import 'package:intl/intl.dart';

import '../../models/purchase_order_detail_model.dart';

class CardPurchaseOrderDetail extends StatefulWidget {
  final List<PurchaseOrderDetailModel> lstPurchaseOrderDetail;
  final int index;
  const CardPurchaseOrderDetail({super.key, required this.lstPurchaseOrderDetail, required this.index});

  @override
  State<CardPurchaseOrderDetail> createState() => _CardPurchaseOrderDetailState();
}

class _CardPurchaseOrderDetailState extends State<CardPurchaseOrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 5,
          left: 5,
          right: 5,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color:widget.lstPurchaseOrderDetail[widget.index].amountReceived == 0  || widget.lstPurchaseOrderDetail[widget.index].amountReceived == 0.0? Colors.white : Colors.lightGreenAccent,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset:const Offset(0, 3), // changes position of shadow
                  ),
                ]
            ),
            child:  Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Text("Cad. Minima: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
                            Text('25/03/2023',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black26),),
                          ],
                        ),
                        InkWell(
                          onTap: (){
                            messageSnackBar("Aqui abre el catalogo");
                            //showDialogInfoInput();
                          },
                          child: const Icon(Icons.note_add),
                        )

                      ],
                    ),
                    Align(alignment: Alignment.center,child: Text(widget.lstPurchaseOrderDetail[widget.index].name!,
                      style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black26),),),
                    const SizedBox(height: 10,),
                    _buildARowInt('Cant. Solicitada:', widget.lstPurchaseOrderDetail[widget.index].quantity),
                    _buildARowInt('Cant. Recepcionada:', widget.lstPurchaseOrderDetail[widget.index].amountReceived),
                    _buildARowDouble('Costo unitario orden:', widget.lstPurchaseOrderDetail[widget.index].unitPrice),
                    _buildARowDouble('Costo unitario:', widget.lstPurchaseOrderDetail[widget.index].unitCost),
                  ],
                )
            )
        )
        )
      ],
    );
  }

  Widget _buildARowDouble(String label, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
        Text(formatCurrency(value),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color:value == 0.0 ? Colors.redAccent : Colors.green)),
      ],
    );
  }
  Widget _buildARowInt(String label, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
        Text('$value',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: value == 0 ? Colors.redAccent : Colors.green)),
      ],
    );
  }


  String formatCurrency(double amount) {
    // use 'es_US' si prefieres el formato en dólares
    final currencyFormat = NumberFormat.currency(locale: 'es_MX', symbol: '\$');
    return currencyFormat.format(amount);
  }


  void messageSnackBar(String message){
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
