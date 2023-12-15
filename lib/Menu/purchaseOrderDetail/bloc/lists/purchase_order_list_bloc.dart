import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/lists/purchase_order_list_event.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/lists/purchase_order_list_state.dart';
import 'package:gomart/Splahs/bloc/splahsDB/splahs_local_event.dart';

class PurchaseOrderListBloc extends Bloc<PurchaseOrderListEvent, PurchaseOrderListState>{

  PurchaseOrderListBloc():super(PurchaseOrderListState()){
    on<OrderListEvent>(_orderListEvent);
    on<SumOrderTotalsEvent>(_sumOrderTotalsEvent);
    //on<ValidateInputDialogEvent>(_validateInputDialogEvent);
  }

  void _orderListEvent(OrderListEvent event, Emitter<PurchaseOrderListState> emit){
    //print("Lista nueva ${event.orderList.toString()}");
    emit(OrderListState(orderList: event.orderList));
  }

  void _sumOrderTotalsEvent(SumOrderTotalsEvent event, Emitter<PurchaseOrderListState> emit){
    //print("Cantidad ${event.totalQuantity}");
    emit(SumOrderTotalsState(totalQuantity: event.totalQuantity, ieps: event.ieps, iva: event.iva, subTotal: event.subTotal, total: event.total));
  }

  // void _validateInputDialogEvent(ValidateInputDialogEvent event, Emitter<PurchaseOrderListState> emit){
  //   print("Validation ${event.isvalidCost}");
  //   emit(ValidateInputDialogState(isCost: event.isvalidCost));
  // }
}