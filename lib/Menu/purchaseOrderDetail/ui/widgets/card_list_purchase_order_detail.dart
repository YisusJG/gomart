import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Helpers/dialogs/purchase_detail_dialog.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/api/reception/reception_bloc.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/api/reception/reception_event.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/barcode/order_barcode_bloc.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/barcode/order_barcode_state.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/inputs/purchase_order_detail_inputs_state.dart';
import 'package:gomart/Menu/purchaseOrderDetail/ui/widgets/card_purchase_order_detail.dart';
import 'package:gomart/Menu/receptionGifts/ui/screen/gifts_screen.dart';
import '../../../../Helpers/scan_barcode_channel.dart';
import '../../../../Helpers/dialogs/type_dialog.dart';
import '../../../options/ui/screen/options_screen.dart';
import '../../../purchaseOrder/models/reference_order_model.dart';
import '../../bloc/api/reception/reception_state.dart';
import '../../bloc/barcode/order_barcode_event.dart';
import '../../bloc/inputs/purchase_order_detail_inputs_bloc.dart';
import '../../bloc/reception/purchase_order_list_bloc.dart';
import '../../bloc/reception/purchase_order_list_event.dart';
import '../../bloc/reception/purchase_order_list_state.dart';
import '../../models/reception_detail_model.dart';
import '../../models/reception_model.dart';

class CardListPurchaseOrderDetail extends StatefulWidget {
  final List<ReceptionDetailModel> lstReceptionDetail;
  final ReferenceOrderModel referenceOrderModel;
  const CardListPurchaseOrderDetail({super.key, required this.lstReceptionDetail, required this.referenceOrderModel});

  @override
  State<CardListPurchaseOrderDetail> createState() => _CardListPurchaseOrderDetailState();
}

class _CardListPurchaseOrderDetailState extends State<CardListPurchaseOrderDetail> {
  ScanBarcodeChannel barcodeChannel = ScanBarcodeChannel();
  static const MethodChannel scannerChannel = MethodChannel('barcode_channel');
  String barcode = '';
  final ScrollController _scrollController = ScrollController();
  late int countFinishOrder= 0;
  late TypeDialog dialog;
  TextEditingController observationsController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<PurchaseOrderListBloc>().add(OrderListEvent(receptionDetail: widget.lstReceptionDetail));
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
        //print("hay nota ${stateInputProduc.note}");
        ReceptionDetailModel targetProduct = widget.lstReceptionDetail
            .firstWhere((product) => product.productId == stateInputProduc.id);

        targetProduct.unitPrice = stateInputProduc.productCost;
        targetProduct.quantity = stateInputProduc.amountReceived;
        targetProduct.subtotal = stateInputProduc.subtotal;
        targetProduct.lessQuantityNotes = stateInputProduc.note;
        targetProduct.discount = stateInputProduc.discount;
        targetProduct.insertDate = stateInputProduc.inserDate;
        targetProduct.branchId = widget.referenceOrderModel.branchId;
        targetProduct.total = stateInputProduc.total;
        targetProduct.isReceived = stateInputProduc.isReceived;
        //targetProduct.insertUserId = 1; //Hacerlo dinamico aqui


       // print("Mi orden de compra anterior ${widget.lstPurchaseOrderDetail.length}");
        context.read<PurchaseOrderListBloc>().add(OrderListEvent(receptionDetail: widget.lstReceptionDetail));
        _scrollToEditedCard(stateInputProduc.id);



      }
      return BlocListener<OrderBarcodeBloc, OrderBarcodeState>(listener: (contextBarcodeListener,stateBarcodeListener){
        var filterProduct = widget.lstReceptionDetail.where((x) => x.barcode == stateBarcodeListener.barcode || (x.productBarCodes != null &&
            x.productBarCodes!.any((barcode) => barcode.barcode == stateBarcodeListener.barcode)),);

        if(filterProduct.isNotEmpty){
          if(filterProduct.first.isReceived){
            messagesSnackBar("Este producto ya lo has recepcionado");
          }else{
            showDialogInfoInput(filterProduct.first);
          }


        }else{
          messagesSnackBar("El producto no se encuentra en la orden de compra");
        }
      },
        child: BlocListener<PurchaseOrderListBloc,PurchaseOrderListState>(listener: (contextOrderListListener, stateOrderListListener){
          final orderList = stateOrderListListener.receptionDetail;
          if(orderList != null){
            final completePurchaseOrder = orderList.where((element) => element.quantity == 0);
            if(completePurchaseOrder.isEmpty){
              countFinishOrder++;
              if(countFinishOrder == 1){
                showDialogQuestion("¿Deseas agrega regalos?","Recuerda que despues no podras agregar los regalos");
                //showDialogConfirm();
              }

            }
          }
        },
          child: BlocListener<ReceptionBloc,ReceptionState>(listener: (contextReception, stateReception){
            if(stateReception is SaveReceptionState){
              //print("receptionId ${stateReception.receptionObj?.receptionId}");
              for (var e in widget.lstReceptionDetail) {
                e.receptionId = stateReception.receptionObj!.receptionId;
              }
              //print("receptionDetail ${widget.lstReceptionDetail.map((e) => e.toJson())}");
              context.read<ReceptionBloc>().add(SaveReceptionDetailsEvent(details: widget.lstReceptionDetail));

            }else if(stateReception is ErrorSaveReception){
              debugPrint("Ocurrio un erro");
              // solo provar cuando noe stemo en la red
              messagesSnackBar(stateReception.errorApi);
              closingDialog();
              showDialogConfirm();
            }
          },
          child: BlocListener<ReceptionBloc, ReceptionState>(listener: (contextReceptionDetail, stateReceptionDetail){
            if(stateReceptionDetail is SaveReceptionDetailsState){
              showDialogSucces("Guardado exitoso",stateReceptionDetail.message);
            }else if(stateReceptionDetail is ErrorSaveReceptionDetails){
              messagesSnackBar(stateReceptionDetail.errorApi);
            }
          },
            child: BlocBuilder<PurchaseOrderListBloc,PurchaseOrderListState>(builder: (contextOrderList, stateOrderList){
              if(stateOrderList.receptionDetail != null){
                return ListView.builder(
                    controller: _scrollController,
                    itemCount: stateOrderList.receptionDetail!.length,
                    itemBuilder: (context,index) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height/2.8,
                        child: CardPurchaseOrderDetail(lstReceptionDetail: stateOrderList.receptionDetail!, index: index,),
                      );
                    }
                );
              }
              return Container();
            }
            ),
           ),
          ),
        ),
      );
    });

  }

  void showDialogInfoInput(ReceptionDetailModel receptionDetailModel){
    PurchaseDetailDialog dialog = PurchaseDetailDialog(context: context);
    dialog.showDialogInfoInput(receptionDetailModel);
  }

  void showDialogUpluading(String description){
     dialog = TypeDialog(
         context: context,
         description:description
     );
    dialog.showDialogUploading();
  }

  void showDialogConfirm(){
    dialog =
    TypeDialog(
        context: context,
        onOk: (){
          ReceptionModel reception = addPurchaseReception();
          //context.read<PurchaseOrderListBloc>().add(OrderListEvent(receptionDetail: widget.lstReceptionDetail));
          context.read<ReceptionBloc>().add(SaveReceptionEvent(receptionModel: reception));
          showDialogUpluading("Guardando orden de compra");
         // messagesSnackBar("reception ${reception.toJson()}");



        },
        observationsController: observationsController
    );
    dialog.showDialogConfirmBody();
  }

  ReceptionModel addPurchaseReception(){
    ReceptionModel reception = ReceptionModel(
      receptionTypeId: 1,
      receptionStatusId: 1,
      purchaseOrderId: widget.referenceOrderModel.orderId,
      subtotal: widget.lstReceptionDetail.fold(0, (double sum , ReceptionDetailModel x) => sum + x.subtotal),
      iva: widget.lstReceptionDetail.fold(0, (double sum , ReceptionDetailModel x) => sum + x.iva),
      ieps: widget.lstReceptionDetail.fold(0, (double sum , ReceptionDetailModel x) => sum + x.ieps),
      discount: widget.lstReceptionDetail.fold(0, (double sum , ReceptionDetailModel x) => sum + x.discount),
      total: widget.lstReceptionDetail.fold(0, (double sum , ReceptionDetailModel x) => sum + x.subtotal + x.iva + x.ieps - x.discount),
      totalQuantity: widget.lstReceptionDetail.fold(0, (int sum , ReceptionDetailModel x) => sum + x.quantity),
      notes: observationsController.text,
      branchId: widget.referenceOrderModel.branchId,
      sapCode: widget.referenceOrderModel.sapCode, // descomentar cuando ya tengamos el sapcode
      insertUserId: 1, //Cambiar esto que sea dinamicoa
      providerReference: widget.referenceOrderModel.providerReference,
      typeDocumentsReceptionId: widget.referenceOrderModel.typeDocumentId,
    );
    return reception;
  }

  void showDialogSucces(String title, String description) {
    dialog = TypeDialog(
      context: context,
      title: title,
      description: description,
      onOk: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OptionsScreen()),
        );
      }
    );
    dialog.showDialogSucces();
  }

  void messagesSnackBar(String message){
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showDialogQuestion(String title, String description){
    dialog = TypeDialog(
        context: context,
        title: title,
        description: description,
        onCancel: (){
          showDialogConfirm();
        },
        onOk: (){
          ReceptionModel purchaseReception = addPurchaseReception();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GiftsScreen(providerId: widget.referenceOrderModel.providerId, purchaseReception: purchaseReception,purchaseReceptionDetail: widget.lstReceptionDetail,)),
          );
          //closingDialog();
        }
    );
    dialog.showDialogQuestion("Si","No");
  }

  void closingDialog(){
    Navigator.pop(context);
  }

  void _scrollToEditedCard(int editedCardId) {
    int editedCardIndex = widget.lstReceptionDetail.indexWhere((product) => product.productId == editedCardId);

    if (editedCardIndex != -1) {
      _scrollController.animateTo(
        editedCardIndex * (MediaQuery.of(context).size.height/2.8),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}
