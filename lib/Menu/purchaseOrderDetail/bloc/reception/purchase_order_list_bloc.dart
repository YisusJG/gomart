import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/reception/purchase_order_list_event.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/reception/purchase_order_list_state.dart';

class PurchaseOrderListBloc extends Bloc<PurchaseOrderListEvent, PurchaseOrderListState>{

  PurchaseOrderListBloc():super(PurchaseOrderListState()){
    on<OrderListEvent>(_orderListEvent);
    on<SumOrderTotalsEvent>(_sumOrderTotalsEvent);
    //on<ValidateInputDialogEvent>(_validateInputDialogEvent);
  }

  void _orderListEvent(OrderListEvent event, Emitter<PurchaseOrderListState> emit){
    //print("Lista nueva ${event.orderList.toString()}");
    emit(OrderListState(receptionDetail: event.receptionDetail));
  }

  void _sumOrderTotalsEvent(SumOrderTotalsEvent event, Emitter<PurchaseOrderListState> emit){
    //print("Cantidad ${event.totalQuantity}");
    emit(SumOrderTotalsState(totalQuantity: event.totalQuantity, ieps: event.ieps, iva: event.iva, subTotal: event.subTotal, total: event.total));
  }
}