import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/lists/purchase_order_list_event.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/lists/purchase_order_list_state.dart';

class PurchaseOrderListBloc extends Bloc<PurchaseOrderListEvent, PurchaseOrderListState>{
  static get orderList => null;
  PurchaseOrderListBloc():super(OrderListState(orderList: orderList)){
    on<OrderListEvent>(_orderListEvent);
    on<SumOrderTotalsEvent>(_sumOrderTotalsEvent);
  }

  void _orderListEvent(OrderListEvent event, Emitter<PurchaseOrderListState> emit){
    //print("Lista nueva ${event.orderList.toString()}");
    emit(OrderListState(orderList: event.orderList));
  }

  void _sumOrderTotalsEvent(SumOrderTotalsEvent event, Emitter<PurchaseOrderListState> emit){
    //print("Cantidad ${event.totalQuantity}");
    emit(SumOrderTotalsState(totalQuantity: event.totalQuantity, ieps: event.ieps, iva: event.iva, subTotal: event.subTotal, total: event.total));
  }
}