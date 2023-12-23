import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/purchaseOrder/bloc/api/order/purchase_order_event.dart';
import 'package:gomart/Menu/purchaseOrder/bloc/api/order/purchase_order_state.dart';
import 'package:gomart/Menu/purchaseOrder/repository/purchase_order_repository.dart';


class PurchaseOrderBloc extends Bloc<PurchaseOrderEvent, PurchaseOrderState> {
  final PurchaseOrderRepository purchaseOrderRepository;

  static get purchaseOrderModel => null;

  PurchaseOrderBloc(this.purchaseOrderRepository) :super(PurchaseOrderState()){
    on<LoadPurchaseOrdersEvent>(_purchaseOrderEvent);
  }

  void _purchaseOrderEvent(LoadPurchaseOrdersEvent event, Emitter<PurchaseOrderState> emit)async{
    try{
      print('Recupera ordenes');
      emit(StartingPurchaseOrders(purchaseOrderModel: purchaseOrderModel));
      final purchaseOrders = await purchaseOrderRepository.getAllPurchaseOrders();
      emit(LoadPurchaseOrderState(purchaseOrderModel: purchaseOrders));
    }catch(e){
      emit(ErrorLoadingPurchaseOrder(errorApi: e.toString()));
    }
  }

}
