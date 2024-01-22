import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/inputs/purchase_order_detail_inputs_event.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/inputs/purchase_order_detail_inputs_state.dart';

class PurchaseOrderDatailInputsBloc extends Bloc<PurchaseOrderDetailInputsEvent, PurchaseOrderDetailInputsState>{

  PurchaseOrderDatailInputsBloc():super(PurchaseOrderDetailInputsState()){
    on<InputProductCostEvent>(_onInputAmountReceivedEvent);
  }

  void _onInputAmountReceivedEvent(InputProductCostEvent event, Emitter<PurchaseOrderDetailInputsState> emit){
    emit(InputProductCostState(productCost: event.productCost, id: event.id, amountReceived: event.amountreceived,
        note: event.note, subtotal: event.subTotal,discount: event.discount, inserDate: event.inserDate, total: event.total, isReceived: event.isReceived,));
  }
}