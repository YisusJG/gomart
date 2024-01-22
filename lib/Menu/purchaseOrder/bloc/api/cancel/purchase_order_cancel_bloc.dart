import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/purchaseOrder/bloc/api/cancel/purchase_order_cancel_event.dart';
import 'package:gomart/Menu/purchaseOrder/bloc/api/cancel/purchase_order_cancel_state.dart';

import '../../../repository/purchase_order_repository.dart';

class PurchaseOrderCancelBloc extends Bloc<PurchaseOrderCancelEvent, PurchaseOrderCancelState>{
  final PurchaseOrderRepository purchaseOrderRepository;

  PurchaseOrderCancelBloc(this.purchaseOrderRepository): super(PurchaseOrderCancelState()){
    on<CancelReceptionEvent>(_cancelReceptionEvent);
  }

  void _cancelReceptionEvent(CancelReceptionEvent event, Emitter<PurchaseOrderCancelState> emit)async{
    try{
      //print("Reception ${event.receptionModel.toJson()}");
      final messageReception = await purchaseOrderRepository.cancelReception(receptionModel: event.receptionModel);
      emit(CancelReceptionState(message: messageReception.messaje));
      //print("ReceptionId ${reception.receptionId}");

    }catch(e){
      emit(ErrorCancelReception(errorApi: e.toString()));
    }
  }

}