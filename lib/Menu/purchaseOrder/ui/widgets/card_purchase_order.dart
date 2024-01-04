import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Helpers/dialogs/purchase_order_dialog.dart';
import 'package:gomart/Menu/purchaseOrder/bloc/api/catDocumentReception/cat_type_document_reception_state.dart';
import 'package:gomart/Menu/purchaseOrder/models/reference_order_model.dart';
import 'package:gomart/Menu/purchaseOrder/models/type_document_reception_model.dart';
import 'package:gomart/Menu/purchaseOrderDetail/ui/screen/purchase_order_detail_screen.dart';

import '../../../../Constants/app_colors.dart';
import '../../../../Helpers/get_color_hexadecimal.dart';
import '../../bloc/api/catDocumentReception/cat_type_document_reception_bloc.dart';
import '../../models/purchase_order_model.dart';

class CardPurchaseOrder extends StatefulWidget {
  final List<PurchaseOrderModel> purchaseOrderModel;
  final int index;
  const CardPurchaseOrder({super.key, required this.purchaseOrderModel, required this.index});

  @override
  State<CardPurchaseOrder> createState() => _CardPurchaseOrderState();
}

class _CardPurchaseOrderState extends State<CardPurchaseOrder> {
  late PurchaseOrderDialog dialog;
  TextEditingController  providerReferenceController = TextEditingController();
  TextEditingController typeDocumentController = TextEditingController();
  bool isValid = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details){
        //DESCOMENTAR EN CASO DE QUE SE LE QUEIRA DAR CLIK A AL CARD
       //  // if (!_isInsideDetailArea(details.globalPosition)) {
       //
       //  // }else{
       //    messagesSnackBar("Aqui validar el proceso de recepcion");
       // // }
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
              child:  Column(
                children: [
                  Padding(padding: const EdgeInsets.only(right: 10),
                    child: Align(alignment: Alignment.centerRight, child:Text(widget.purchaseOrderModel[widget.index].insertDate,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black26),),),
                  ),
                  const SizedBox(height: 10,),
                  Padding(padding: const EdgeInsets.only(right: 10,left: 10),
                  child: Row(
                    children: [
                      const Text('Estatus:  ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(widget.purchaseOrderModel[widget.index].namePurchaseOrderStatus,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black26),),
                    ],
                  ),
                  ),
                  Padding(padding:  const EdgeInsets.only(right: 10,left: 10),
                  child: Row(
                    children: [
                      const Text('Provedor:  ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      Expanded(child:  Text(widget.purchaseOrderModel[widget.index].nameProvider,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black26),),),

                    ],
                  ),
                  ),
                  Padding(padding:  const EdgeInsets.only(right: 10,left: 10),
                  child:Row(
                    children: [
                      const Text('Tipo de orden:  ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(widget.purchaseOrderModel[widget.index].namePurchaseOrderType,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black26),),
                    ],
                  ),
                  ),
                  const SizedBox(height: 5,),
                  BlocBuilder<CatTypeDocumentReceptionBloc, CatTypeDocumentReceptionState>(builder: (contextDocumentReception,stateDocumentReception){
                    return  Padding(padding: const EdgeInsets.only(right: 0,left: 0),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: (){
                                  //showPurchaseOrderDialog(stateDocumentReception.typeDocument!);
                                  showCancelPurchaseOrder();
                                  //messagesSnackBar("Aqui se va hacer la cancelacion");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 100,
                                      //color: Color(getColorHexadecimal(primaryColor)),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.zero,
                                          topRight: Radius.circular(20.0),
                                          bottomLeft: Radius.circular(10.0),
                                          bottomRight: Radius.zero,
                                        ),
                                        color: Color(getColorHexadecimal(colorCancel)),
                                      ),
                                      //color: Color(getColorHexadecimal(primaryColor)),
                                      child: Row(
                                        //mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Icon(Icons.arrow_back_ios_sharp,color: Color(getColorHexadecimal(secondaryColor))),
                                          const SizedBox(width: 2,),
                                          Text("Cancelar", style: TextStyle(fontSize: 14, color: Color(getColorHexadecimal(secondaryColor)))),

                                        ],
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            InkWell(
                                onTap: (){
                                  showPurchaseOrderDialog(stateDocumentReception.typeDocument!);
                                  //messagesSnackBar("Aqui se mostrara el detalle");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
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
                                          Text("Recepcion", style: TextStyle(fontSize: 14, color: Color(getColorHexadecimal(secondaryColor)))),
                                          const SizedBox(width: 2,),
                                          Icon(Icons.arrow_forward_ios_sharp,color: Color(getColorHexadecimal(secondaryColor))),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                            )
                          ],
                        )

                    );
                  }),
                ],
              )
            ),
          ),
        ],
      ),
    );
  }

  // descomentar esto en caso de que solo querramos recuperar el boton de la recepcion
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


  void showPurchaseOrderDialog(List<TypeDocumentReceptionModel> documentReception){
    //print("que llega document ${documentReception.length}");
    dialog =
    PurchaseOrderDialog(
        context: context,
        onCancel: (){
          closingDialog();
        },
        onOk: (){
          if(providerReferenceController.text.isEmpty || typeDocumentController.text.isEmpty){
            messagesSnackBar("Para continuar debes de agregar una referencia del provedor y un tipo de documento");
            closingDialog();
          }else{
            ReferenceOrderModel referenceOrderModel =
            ReferenceOrderModel(
              orderId: widget.purchaseOrderModel[widget.index].id,
              branchId: widget.purchaseOrderModel[widget.index].branchId,
              typeDocumentId: int.parse(typeDocumentController.text),
              sapCode: widget.purchaseOrderModel[widget.index].sapCode,
              providerReference: providerReferenceController.text,
            );
            //print("Datos referencia ${referenceOrderModel.typeDocumentId}");
            closingDialog();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PurchaseOrderDetailScreen(referenceOrderModel: referenceOrderModel,)),
            );

          }
        },
      providerCpntroller: providerReferenceController,
      typeDocumentController: typeDocumentController,
    );
    dialog.showPurchaseReferenceDialog(documentReception);
  }

  void showCancelPurchaseOrder(){
    dialog = PurchaseOrderDialog(context: context);
    dialog.cancelPurchaseOrderDialog();
  }

  void messagesSnackBar(String message){
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void closingDialog(){
    Navigator.pop(context);
  }
}

