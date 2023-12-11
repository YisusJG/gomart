import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/barcode/order_barcode_event.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/barcode/order_barcode_state.dart';

class OrderBarcodeBloc extends Bloc<OrderBarcodeEvent, OrderBarcodeState>{
  static get barcode => '';

  OrderBarcodeBloc():super(BarcodeState(barcode: barcode)){
    on<BarcodeEvent>(_barcodeEvent);
  }

  void _barcodeEvent(BarcodeEvent event, Emitter<OrderBarcodeState> emit){
    emit(BarcodeState(barcode: event.barcode));
  }
}