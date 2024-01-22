

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/receptionGifts/bloc/barcode/gifts_barcode_state.dart';
import 'package:gomart/Menu/receptionGifts/bloc/buton/click_button_bloc.dart';
import 'package:gomart/Menu/receptionGifts/bloc/buton/click_button_state.dart';
import 'package:gomart/Menu/receptionGifts/bloc/list/gifts_list_bloc.dart';
import 'package:gomart/Menu/receptionGifts/bloc/list/gifts_list_state.dart';
import 'package:gomart/Menu/receptionGifts/ui/widgets/card_gifts.dart';

import '../../../../Helpers/dialogs/type_dialog.dart';
import '../../../../Helpers/scan_barcode_channel.dart';
import '../../../options/ui/screen/options_screen.dart';
import '../../../purchaseOrderDetail/bloc/api/reception/reception_bloc.dart';
import '../../../purchaseOrderDetail/bloc/api/reception/reception_event.dart';
import '../../../purchaseOrderDetail/bloc/api/reception/reception_state.dart';
import '../../../purchaseOrderDetail/models/reception_detail_model.dart';
import '../../../purchaseOrderDetail/models/reception_model.dart';
import '../../bloc/barcode/gifts_barcode_bloc.dart';
import '../../bloc/barcode/gifts_barcode_event.dart';
import '../../bloc/list/gifts_list_event.dart';
import '../../models/reception_gifts_model.dart';

class CardListGifts extends StatefulWidget {
  final ReceptionModel purchaseReception;
  final List<ReceptionDetailModel> purchaseReceptionDetail;
  const CardListGifts({super.key, required this.purchaseReception, required this.purchaseReceptionDetail});

  @override
  State<CardListGifts> createState() => _CardListGiftsState();
}

class _CardListGiftsState extends State<CardListGifts> {
  ScanBarcodeChannel barcodeChannel = ScanBarcodeChannel();
  static const MethodChannel scannerChannel = MethodChannel('barcode_channel');
  String barcode = '';
  late TypeDialog dialog;
  TextEditingController amounController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    //context.read<PurchaseOrderListBloc>().add(OrderListEvent(receptionDetail: widget.lstReceptionDetail));
    scannerChannel.setMethodCallHandler((call) {
      if (call.method == 'scanBarcode') {
        context.read<GiftsBarcodeBloc>().add(
          BarcodeGiftsEvent(barcode: call.arguments),);
      }
      return Future.value();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReceptionBloc>(create: (context) => ReceptionBloc(RepositoryProvider.of(context)),
      child: BlocBuilder<GiftsListBloc,GiftsListState>(builder: (contextGifts, stateGifts){
      if(stateGifts is ListState){
        print("Entra 1");
        return BlocListener<ClickButtonBloc, ClickButtonState>(listener: (contextClick,stateClick){
          if (stateGifts.receptionGifts!.any((gift) => gift.quantity > 0)) {
            showDialogQuestion(contextClick,"¿Estas seguro de enviar la recepcion?","Recuerda que una ves enviado, ya no se mostrara la orden de compra");
          } else {
            showAlert("Aviso", "Agrega por lo menos un regalo para continuar");
          }
          print("Entra solo al click");
        },
            child: BlocListener<ReceptionBloc,ReceptionState>(listener: (contextReception, stateReception){
              if(stateReception is SaveReceptionState){
                for (var e in widget.purchaseReceptionDetail) {
                  e.receptionId = stateReception.receptionObj!.receptionId;
                }
                //print("receptionDetail ${widget.lstReceptionDetail.map((e) => e.toJson())}");
                contextGifts.read<ReceptionBloc>().add(SaveReceptionDetailsEvent(details: widget.purchaseReceptionDetail));

              }else if(stateReception is ErrorSaveReception){
                messagesSnackBar(stateReception.errorApi);
              }
            },
              child: BlocListener<ReceptionBloc, ReceptionState>(listener: (contextReceptionDetail, stateReceptionDetail){
                if(stateReceptionDetail is SaveReceptionDetailsState){

                  //showDialogSucces("Guardado exitoso",stateReceptionDetail.message);
                }else if(stateReceptionDetail is ErrorSaveReceptionDetails){
                  messagesSnackBar(stateReceptionDetail.errorApi);
                }
              },
                child: BlocListener<GiftsBarcodeBloc, GiftsBarcodeState>(listener: (contextBarcode,stateBarcode){
                  print("Entra solo al scaner");
                  showInputBasicDialog(stateGifts.receptionGifts!, stateBarcode.barcode);
                },
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: stateGifts.receptionGifts!.length,
                      itemBuilder: (context,index) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height/5.5,
                          child: CardGifts(lsReceptionGifts: stateGifts.receptionGifts!, index: index,),
                        );
                      }
                  ),
                )))
        );
      }
      return Container();
    }),
  );
  }

  void showInputBasicDialog(List<ReceptionGiftsModel> listGift, String barcode){
    var gift = listGift.firstWhere((x) => x.barcode == barcode);
    var productIndex = listGift.indexWhere((x) => x.barcode == barcode);
    dialog = TypeDialog(
      context: context,
      onOk:(){
        if (productIndex != -1) {
          listGift[productIndex].quantity = int.parse(amounController.text);
          context.read<GiftsListBloc>().add(ListEvent(receptionGifts: listGift));
          _scrollToEditedBarcode(productIndex);
        }
        amounController.clear();
      },
      onCancel:(){
        amounController.clear();
      },
      amountController: amounController,
    );
    dialog.showInputBasicDialog(gift.name,gift.nameUnit, "Aceptar", "Cancelar");
  }



  void _scrollToEditedBarcode(int index) {
    _scrollController.animateTo(
      index * (MediaQuery.of(context).size.height / 5.5),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void showAlert(String title, String description){
    dialog  = TypeDialog(context: context, title: title, description: description);
    dialog.showDialogWarning();

  }

  void showDialogQuestion(BuildContext contextGifts, String title, String description){
    dialog = TypeDialog(
        context: context,
        title: title,
        description: description,
        onCancel: (){

        },
        onOk: (){
          showDialogConfirm(contextGifts);
        }
    );
    dialog.showDialogQuestion("Si","No");

  }

  void showDialogConfirm(BuildContext contextGifts){
    dialog =
        TypeDialog(
            context: context,
            onOk: (){
              contextGifts.read<ReceptionBloc>().add(SaveReceptionEvent(receptionModel: widget.purchaseReception));
              showDialogUpluading("Guardando orden de compra");
            },
        );
    dialog.showDialogConfirmBody();
  }

  void showDialogUpluading(String description){
    dialog = TypeDialog(
        context: context,
        description:description
    );
    dialog.showDialogUploading();
  }

  void messagesSnackBar(String message){
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
}
