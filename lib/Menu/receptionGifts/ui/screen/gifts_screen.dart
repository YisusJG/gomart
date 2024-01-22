import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/receptionGifts/bloc/api/products/supplier_products_bloc.dart';
import 'package:gomart/Menu/receptionGifts/bloc/api/products/supplier_products_event.dart';
import 'package:gomart/Menu/receptionGifts/bloc/api/products/supplier_products_state.dart';
import 'package:gomart/Menu/receptionGifts/bloc/buton/click_button_bloc.dart';
import 'package:gomart/Menu/receptionGifts/bloc/list/gifts_list_bloc.dart';
import 'package:gomart/Menu/receptionGifts/ui/widgets/card_list_gifts.dart';

import '../../../../Constants/app_colors.dart';
import '../../../../Helpers/dialogs/type_dialog.dart';
import '../../../../Helpers/get_color_hexadecimal.dart';
import '../../../purchaseOrderDetail/models/reception_detail_model.dart';
import '../../../purchaseOrderDetail/models/reception_model.dart';
import '../../../purchaseOrderDetail/repository/purchase_order_datail_repository.dart';
import '../../bloc/barcode/gifts_barcode_bloc.dart';
import '../../bloc/buton/click_button_event.dart';
import '../../bloc/list/gifts_list_event.dart';
import '../../repository/gifts_repository.dart';

class GiftsScreen extends StatefulWidget {
  final int providerId;
  final ReceptionModel purchaseReception;
  final List<ReceptionDetailModel> purchaseReceptionDetail;
  const GiftsScreen({super.key, required this.providerId, required this.purchaseReception, required this.purchaseReceptionDetail});

  @override
  State<GiftsScreen> createState() => _GiftsScreenState();
}

class _GiftsScreenState extends State<GiftsScreen> {
  late TypeDialog dialog;
  @override
  Widget build(BuildContext context) {
    return  MultiRepositoryProvider(providers:[
    RepositoryProvider<GiftsRepository>(create: (context) => GiftsRepository()),
    RepositoryProvider<PurchaseOrderDetailRepository>(create: (context) => PurchaseOrderDetailRepository()),
    ],
      child: MultiBlocProvider(providers: [
        BlocProvider<SupplierProductsBloc>(create: (context) => SupplierProductsBloc(RepositoryProvider.of<GiftsRepository>(context))
          ..add(LoadSupplierProductsEvent(providerId: widget.providerId))),
        BlocProvider<GiftsBarcodeBloc>(
          create: (context) => GiftsBarcodeBloc(),
        ),
        //BlocProvider<GiftsListBloc>(create: (context) => GiftsListBloc()),
      ], 
          child: BlocProvider<GiftsListBloc>(create: (context) => GiftsListBloc(),
            child: BlocProvider<ClickButtonBloc>(create: (context) => ClickButtonBloc(),
              child:BlocBuilder<SupplierProductsBloc,SupplierProductsState >(builder:(contextGifts,stateGifts){
                //contextList = contextGifts;
                if(stateGifts is LoadSupplierProductsState){
                  contextGifts.read<GiftsListBloc>().add(ListEvent(receptionGifts: stateGifts.lsReceptionGifts!));
                  return PopScope(
                      canPop: false,
                      onPopInvoked: (bool didPop){
                        if (didPop) {
                          return;
                        }
                        showDialogQuestion("¿Estas seguro de regresar?","Perderas el avance de la recepcion");
                      },
                      child: Scaffold(
                        appBar: AppBar(
                          title: Text(
                            "Recepción de regalos",
                            style: TextStyle(
                                color: Color(getColorHexadecimal(secondaryColor))),
                          ),
                          iconTheme: IconThemeData(
                              color: Color(getColorHexadecimal(secondaryColor))),
                          backgroundColor: Color(getColorHexadecimal(primaryColor)),
                        ),
                        body: Column(
                          children: [
                            Expanded(
                                child: CardListGifts(purchaseReception: widget.purchaseReception, purchaseReceptionDetail: widget.purchaseReceptionDetail,)
                            ),
                          ],
                        ),
                        bottomNavigationBar: CurvedNavigationBar(
                          buttonBackgroundColor: Color(getColorHexadecimal(primaryColor)),
                          backgroundColor: Color(getColorHexadecimal(secondaryColor)),
                          color: Color(getColorHexadecimal(primaryColor)),
                          height: 50.0,
                          //index: 0,
                          items:  [
                            Icon(Icons.save, size: 40,color: Color(getColorHexadecimal(secondaryColor)),),
                            //Icon(Icons.save, size: 40,color: Color(getColorHexadecimal(secondaryColor)),),
                            //Icon(Icons.upload, size: 30, color: Color(getColorHexadecimal(secondaryColor)),),
                          ],
                          onTap: (index){
                            contextGifts.read<ClickButtonBloc>().add(ClickEvent());
                          },
                        ),
                      )
                  );

                }
                return const CircularProgressIndicator();
              }),
            )
          ),
      ),
    );
  }

  void showDialogQuestion(String title, String description){
    dialog = TypeDialog(
        context: context,
        title: title,
        description: description,
        onCancel: (){

        },
        onOk: (){
          closingDialog();
        }
    );
    dialog.showDialogQuestion("Aceptar","Cancelar");

  }

  void closingDialog(){
    Navigator.pop(context);
  }
}
