import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/api/purchase_order_detail_event.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/api/purchase_order_detail_state.dart';
import 'package:gomart/Menu/purchaseOrderDetail/repository/purchase_order_datail_repository.dart';

import '../../models/purchase_order_detail_model.dart';
import '../../models/reception_detail_model.dart';

class PurchaseOrderDetailBloc extends Bloc<PurchaseOrderDetailEvent, PurchaseOrderDetailState>{
  final PurchaseOrderDetailRepository orderDetailRepository;
  static get purchaseOrderDetailModel => null;
  
  PurchaseOrderDetailBloc(this.orderDetailRepository): super(PurchaseOrderDetailState()){
    on<LoadOrderDetailEvent>(_loadOrderDetailEvent);
  }

  void _loadOrderDetailEvent(LoadOrderDetailEvent event, Emitter<PurchaseOrderDetailState> emit) async{
    try{
      emit(StartingPurchaseOrderDetail(receptionDetail: purchaseOrderDetailModel));
      List<PurchaseOrderDetailModel> orderDetail = await orderDetailRepository.getPurchaseOrderDetail(purchaseOrderId: event.purchaseOrderId);
      List<ReceptionDetailModel> receptionDetail = orderDetail.map((PurchaseOrderDetailModel purchaseOrderDetail) {
        return ReceptionDetailModel(
          productId: purchaseOrderDetail.productId,
          unitId: purchaseOrderDetail.unitId,
          poquantity: purchaseOrderDetail.quantity,
          roundingValue: purchaseOrderDetail.roundingValue,
          pounitPrice: purchaseOrderDetail.unitPrice,
          iva: purchaseOrderDetail.iva,
          ieps: purchaseOrderDetail.ieps,
          productName: purchaseOrderDetail.name,
          barcode: purchaseOrderDetail.barcode,
          expiration: purchaseOrderDetail.expiration,
          productBarCodes: purchaseOrderDetail.productBarCodes
        );
      }).toList();
      emit(LoadPurchaseOrderDetail(receptionDetail: receptionDetail));
    }catch(e){
      emit(ErrorPurchaseOrderDetail(errorApi: e.toString()));
    }
  }
}