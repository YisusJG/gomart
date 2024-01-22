import 'package:flutter/material.dart';

import '../../models/reception_gifts_model.dart';

class CardGifts extends StatefulWidget {
  final List<ReceptionGiftsModel> lsReceptionGifts;
  final int index;
  const CardGifts({super.key, required this.lsReceptionGifts, required this.index});

  @override
  State<CardGifts> createState() => _CardGiftsState();
}

class _CardGiftsState extends State<CardGifts> {
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
                    color: widget.lsReceptionGifts[widget.index].quantity >0 ? Colors.lightGreenAccent :  Colors.white,
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
                        Align(alignment: Alignment.center,child: Text(widget.lsReceptionGifts[widget.index].name,
                          style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 14,fontStyle: FontStyle.italic, color: Colors.black26),textAlign: TextAlign.center,),),
                        const SizedBox(height: 5,),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const Text("SAP",style:TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
                                Text(widget.lsReceptionGifts[widget.index].sapmaterial,style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 16,fontStyle: FontStyle.normal, color: Colors.black26),textAlign: TextAlign.center,),
                              ],
                            ),
                            Column(
                              children: [
                                const Text("UNIDAD", style:TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
                                Text(widget.lsReceptionGifts[widget.index].nameUnit,style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 16,fontStyle: FontStyle.normal, color: Colors.black26),textAlign: TextAlign.center,),
                              ],
                            ),
                            Column(
                              children: [
                                const Text("CANTIDAD", style:TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
                                Text('${widget.lsReceptionGifts[widget.index].quantity}',style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 16,fontStyle: FontStyle.normal, color: Colors.black26),textAlign: TextAlign.center,),
                              ],
                            )
                          ]
                        )
                      ],
                    )
                )
            )
        )
      ],
    );
  }
}
