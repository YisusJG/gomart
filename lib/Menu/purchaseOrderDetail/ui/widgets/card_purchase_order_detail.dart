import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/reception_detail_model.dart';

class CardPurchaseOrderDetail extends StatefulWidget {
  final List<ReceptionDetailModel> lstReceptionDetail;
  final int index;
  const CardPurchaseOrderDetail({super.key, required this.lstReceptionDetail, required this.index});

  @override
  State<CardPurchaseOrderDetail> createState() => _CardPurchaseOrderDetailState();
}

class _CardPurchaseOrderDetailState extends State<CardPurchaseOrderDetail> {
  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    DateTime futureDate = currentDate.add(Duration(days: widget.lstReceptionDetail[widget.index].expiration));
    String formattedDate = DateFormat('dd/MM/yyyy').format(futureDate);
    return Stack(
      children: [
        Positioned(
          top: 5,
          left: 5,
          right: 5,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color:!widget.lstReceptionDetail[widget.index].isReceived ? Colors.white : Colors.lightGreenAccent,
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
                        Row(
                          children: [
                            const Text("Cad. Minima: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
                            Text(formattedDate,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black26),),
                          ],
                        ),
                        // InkWell(
                        //   onTap: (){
                        //     messageSnackBar("Aqui abre el catalogo");
                        //     //showDialogInfoInput();
                        //   },
                        //   child: const Icon(Icons.note_add),
                        // )

                      ],
                    ),
                    Align(alignment: Alignment.center,child: Text(widget.lstReceptionDetail[widget.index].productName,
                      style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black26),),),
                    const SizedBox(height: 10,),
                    _buildARowInt('Cant. Solicitada:', widget.lstReceptionDetail[widget.index].poquantity),
                    _buildARowInt('Cant. Recepcionada:', widget.lstReceptionDetail[widget.index].quantity),
                    _buildARowDouble('Costo unitario orden:', widget.lstReceptionDetail[widget.index].pounitPrice),
                    _buildARowDouble('Costo unitario:', widget.lstReceptionDetail[widget.index].unitPrice),
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
