import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Helpers/dialogs/purchase_detail_dialog.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/barcode/order_barcode_bloc.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/barcode/order_barcode_state.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/inputs/purchase_order_detail_inputs_state.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/lists/purchase_order_list_state.dart';
import 'package:gomart/Menu/purchaseOrderDetail/ui/widgets/card_purchase_order_detail.dart';
import '../../../../Helpers/scan_barcode_channel.dart';
import '../../../../Helpers/dialogs/type_dialog.dart';
import '../../bloc/barcode/order_barcode_event.dart';
import '../../bloc/inputs/purchase_order_detail_inputs_bloc.dart';
import '../../bloc/lists/purchase_order_list_bloc.dart';
import '../../bloc/lists/purchase_order_list_event.dart';
import '../../models/purchase_order_detail_model.dart';

class CardListPurchaseOrderDetail extends StatefulWidget {
  final List<PurchaseOrderDetailModel> lstPurchaseOrderDetail;
  const CardListPurchaseOrderDetail({super.key, required this.lstPurchaseOrderDetail});

  @override
  State<CardListPurchaseOrderDetail> createState() => _CardListPurchaseOrderDetailState();
}

class _CardListPurchaseOrderDetailState extends State<CardListPurchaseOrderDetail> {
  ScanBarcodeChannel barcodeChannel = ScanBarcodeChannel();
  static const MethodChannel scannerChannel = MethodChannel('barcode_channel');
  String barcode = '';
  final ScrollController _scrollController = ScrollController();
  late int countFinishOrder= 0;
  @override
  void initState() {
    super.initState();
    context.read<PurchaseOrderListBloc>().add(OrderListEvent(orderList: widget.lstPurchaseOrderDetail));
    scannerChannel.setMethodCallHandler((call) {
      if (call.method == 'scanBarcode') {
        context.read<OrderBarcodeBloc>().add(
          BarcodeEvent(barcode: call.arguments),
        );
      }
      return Future.value();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PurchaseOrderDatailInputsBloc,PurchaseOrderDetailInputsState>(builder: (contextInputProduct,stateInputProduc){
      if(stateInputProduc.id >0){
        PurchaseOrderDetailModel targetProduct = widget.lstPurchaseOrderDetail
            .firstWhere((product) => product.id == stateInputProduc.id);

        targetProduct.unitCost = stateInputProduc.productCost;
        targetProduct.amountReceived = stateInputProduc.amountReceived;

       // print("Mi orden de compra anterior ${widget.lstPurchaseOrderDetail.length}");
        context.read<PurchaseOrderListBloc>().add(OrderListEvent(orderList: widget.lstPurchaseOrderDetail));
        _scrollToEditedCard(stateInputProduc.id);



      }
      return BlocListener<OrderBarcodeBloc, OrderBarcodeState>(listener: (contextBarcodeListener,stateBarcodeListener){
        var productName = widget.lstPurchaseOrderDetail.where((x) => x.barcode == stateBarcodeListener.barcode);
        if(productName.isNotEmpty){
         // print('amount: ${productName.first.amountReceived} qauntity: ${productName.first.unitCost}');
          if(productName.first.amountReceived > 0 || productName.first.unitCost > 0){
            messagesSnackBar("Este producto ya lo has recepcionado");
          }else{
            showDialogInfoInput(productName.first);
          }


        }else{
          messagesSnackBar("El producto no se encuentra en la orden de compra");
        }
      },
        child: BlocListener<PurchaseOrderListBloc,PurchaseOrderListState>(listener: (contextOrderListListener, stateOrderListListener){
          final orderList = stateOrderListListener.orderList;
          if(orderList != null){
            final completePurchaseOrder = orderList.where((element) => element.amountReceived == 0);
            if(completePurchaseOrder.isEmpty){
              countFinishOrder++;
              if(countFinishOrder == 1){
                showDialogConfirm("Orden de compra completada",'Favor de enviar la recepcion');
              }

            }
          }
        },
          child: BlocBuilder<PurchaseOrderListBloc,PurchaseOrderListState>(builder: (contextOrderList, stateOrderList){
            if(stateOrderList.orderList != null){
              return ListView.builder(
                  controller: _scrollController,
                  itemCount: stateOrderList.orderList!.length,
                  itemBuilder: (context,index) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height/2.8,
                      child: CardPurchaseOrderDetail(lstPurchaseOrderDetail: stateOrderList.orderList!, index: index,),
                    );
                  }
              );
            }
            return Container();
          }),
        ),
      );
    });

  }

  void showDialogInfoInput(PurchaseOrderDetailModel purchaseOrderDetailModel){
    PurchaseDetailDialog dialog = PurchaseDetailDialog(context: context);
    dialog.showDialogInfoInput(purchaseOrderDetailModel);
  }

  void showDialogConfirm(String title,String description){
    TypeDialog dialog =
    TypeDialog(
        context: context,
        title: title,
        description: description,
        onOk: (){

        }
    );
    dialog.showDialogConfirm();
  }

  void messagesSnackBar(String message){
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _scrollToEditedCard(int editedCardId) {
    int editedCardIndex = widget.lstPurchaseOrderDetail.indexWhere((product) => product.id == editedCardId);

    if (editedCardIndex != -1) {
      _scrollController.animateTo(
        editedCardIndex * (MediaQuery.of(context).size.height / 2.8),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}
