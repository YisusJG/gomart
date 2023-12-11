import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/inputs/purchase_order_detail_inputs_event.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/inputs/purchase_order_detail_inputs_state.dart';

class PurchaseOrderDatailInputsBloc extends Bloc<PurchaseOrderDetailInputsEvent, PurchaseOrderDetailInputsState>{
  static get productCost => 0.0;
  static get id => 0;
  static get amountReceived => 0;
  PurchaseOrderDatailInputsBloc():super(InputProductCostState(productCost: productCost, id: id, amountReceived: amountReceived)){
    on<InputProductCostEvent>(_onInputAmountReceivedEvent);
  }

  void _onInputAmountReceivedEvent(InputProductCostEvent event, Emitter<PurchaseOrderDetailInputsState> emit){
    emit(InputProductCostState(productCost: event.productCost, id: event.id, amountReceived: event.amountreceived));
  }
}