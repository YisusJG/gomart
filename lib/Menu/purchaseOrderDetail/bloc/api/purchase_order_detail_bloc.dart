import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/api/purchase_order_detail_event.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/api/purchase_order_detail_state.dart';
import 'package:gomart/Menu/purchaseOrderDetail/repository/purchase_order_datail_repository.dart';

class PurchaseOrderDetailBloc extends Bloc<PurchaseOrderDetailEvent, PurchaseOrderDetailState>{
  final PurchaseOrderDetailRepository orderDetailRepository;
  static get purchaseOrderDetailModel => null;
  
  PurchaseOrderDetailBloc(this.orderDetailRepository): super(StartingPurchaseOrderDetail(purchaseOrderDetailModel: purchaseOrderDetailModel)){
    on<LoadOrderDetailEvent>(_loadOrderDetailEvent);
  }

  void _loadOrderDetailEvent(LoadOrderDetailEvent event, Emitter<PurchaseOrderDetailState> emit) async{
    try{
      emit(StartingPurchaseOrderDetail(purchaseOrderDetailModel: purchaseOrderDetailModel));
      final orderDetail = await orderDetailRepository.getPurchaseOrderDetail(purchaseOrderId: event.purchaseOrderId);
      emit(LoadPurchaseOrderDetail(purchaseOrderDetailModel: orderDetail));
    }catch(e){
      emit(ErrorPurchaseOrderDetail(errorApi: e.toString()));
    }
  }
}