import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/api/reception/reception_event.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/api/reception/reception_state.dart';
import 'package:gomart/Menu/purchaseOrderDetail/models/reception_obj.dart';
import '../../../repository/purchase_order_datail_repository.dart';

class ReceptionBloc extends Bloc<ReceptionEvent,ReceptionState>{
  final PurchaseOrderDetailRepository orderDetailRepository;

  ReceptionBloc(this.orderDetailRepository): super (ReceptionState()){
    on<SaveReceptionEvent>(_saveReceptionEvent);
    on<SaveReceptionDetailsEvent>(_saveReceptionDetailsEvent);

  }

  void _saveReceptionEvent(SaveReceptionEvent event, Emitter<ReceptionState> emit)async{
    try{
      //print("Reception ${event.receptionModel.toJson()}");
      ReceptionObj reception = await orderDetailRepository.saveReception(receptionModel: event.receptionModel);
      emit(SaveReceptionState(receptionObj: reception));
      //print("ReceptionId ${reception.receptionId}");

    }catch(e){
      emit(ErrorSaveReception(errorApi: e.toString()));
    }
  }

  void _saveReceptionDetailsEvent(SaveReceptionDetailsEvent event, Emitter<ReceptionState> emit)async{
    try{
      //print("ReceptionDeatils ${event.details.length}");
      //print("receptionDetail ${event.details.map((e) => e.toJson())}");
      final messageDetails = await orderDetailRepository.saveReceptionDetails(receptionDetail: event.details);
      emit(SaveReceptionDetailsState(message: messageDetails.messaje));
      //print("ReceptionId ${reception.receptionId}");

    }catch(e){
      emit(ErrorSaveReceptionDetails(errorApi: e.toString()));
    }
  }
}