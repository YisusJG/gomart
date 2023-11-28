import 'package:flutter/material.dart';
import 'package:gomart/Menu/purchaseOrderDetail/ui/screen/purchase_order_detail_screen.dart';

import '../../../../Constants/app_colors.dart';
import '../../../../Helpers/get_color_hexadecimal.dart';
import '../../models/purchase_order_model.dart';

class CardPurchaseOrder extends StatefulWidget {
  final List<PurchaseOrderModel> purchaseOrderModel;
  final int index;
  const CardPurchaseOrder({super.key, required this.purchaseOrderModel, required this.index});

  @override
  State<CardPurchaseOrder> createState() => _CardPurchaseOrderState();
}

class _CardPurchaseOrderState extends State<CardPurchaseOrder> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details){
        // if (!_isInsideDetailArea(details.globalPosition)) {

        // }else{
          messagesSnackBar("Aqui validar el proceso de recepcion");
       // }
      },
      child: Stack(
        children: [
          Positioned(
            top: 10,
            right: 100,
            left: 100,
            child: Container(
              height: 50.0,
              width: 120,
              decoration: BoxDecoration(
                color:
                widget.purchaseOrderModel[widget.index].namePurchaseOrderStatus == "Emitida" ?  Color(getColorHexadecimal(primaryColor)) :
                widget.purchaseOrderModel[widget.index].namePurchaseOrderStatus == "Enviada A Proveedor" ? Colors.orange:
                widget.purchaseOrderModel[widget.index].namePurchaseOrderStatus == "Cancelada" ? Colors.red :
                Colors.green,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.7),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child:  Center(
                  child: Column(
                    children: [
                      Text(widget.purchaseOrderModel[widget.index].purchaseOrderFolio,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 10,
            left: 10,
            child: Container(
              width: MediaQuery.of(context).size.width / 1.3,
              //height: MediaQuery.of(context).size.height /5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child:  Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(padding: const EdgeInsets.only(right: 10),
                      child: Align(alignment: Alignment.centerRight, child:Text(widget.purchaseOrderModel[widget.index].insertDate,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black26),),),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text('Estatus:  ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text(widget.purchaseOrderModel[widget.index].namePurchaseOrderStatus,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black26),),
                      ],
                    ),
                    Row(
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text('Provedor:  ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        Expanded(child:  Text(widget.purchaseOrderModel[widget.index].nameProvider,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black26),),),

                      ],
                    ),
                    Row(
                      //crossAxisAlignment: CrossAxisAlignment.spaceAround,
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text('Tipo de orden:  ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text(widget.purchaseOrderModel[widget.index].namePurchaseOrderType,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black26),),
                      ],
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PurchaseOrderDetail()),
                            );
                            //messagesSnackBar("Aqui se mostrara el detalle");
                          },
                          child: Container(
                            height: 30,
                            width: 100,
                            //color: Color(getColorHexadecimal(primaryColor)),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.zero,
                                bottomLeft: Radius.zero,
                                bottomRight: Radius.circular(10.0),
                              ),
                              color: Color(getColorHexadecimal(primaryColor)),
                            ),
                            //color: Color(getColorHexadecimal(primaryColor)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Detalle", style: TextStyle(fontSize: 14, color: Color(getColorHexadecimal(secondaryColor)))),
                                const SizedBox(width: 10,),
                                Icon(Icons.arrow_forward_ios_sharp,color: Color(getColorHexadecimal(secondaryColor))),
                              ],
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // bool _isInsideDetailArea(Offset globalPosition) {
  //
  //   RenderBox box = context.findRenderObject() as RenderBox;
  //   Offset localPosition = box.globalToLocal(globalPosition);
  //
  //   double detailAreaLeft = 10;
  //   double detailAreaTop = 40;
  //   double detailAreaRight = MediaQuery.of(context).size.width - 10;
  //   double detailAreaBottom = MediaQuery.of(context).size.height / 5 + 40;
  //
  //   return localPosition.dx >= detailAreaLeft &&
  //       localPosition.dx <= detailAreaRight &&
  //       localPosition.dy >= detailAreaTop &&
  //       localPosition.dy <= detailAreaBottom;
  // }

  void messagesSnackBar(String message){
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

