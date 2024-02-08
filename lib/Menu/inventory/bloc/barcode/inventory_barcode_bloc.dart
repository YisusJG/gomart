import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/barcode/inventory_barcode_event.dart';
import 'package:gomart/Menu/inventory/bloc/barcode/inventory_barcode_state.dart';

class InventoryBarcodeBloc extends Bloc<InventoryBarcodeEvent, InventoryBarcodeState>{
  static get barcode => '';

  InventoryBarcodeBloc():super(BarcodeState(barcode: barcode)){
    on<BarcodeEvent>(_barcodeEvent);
  }

  void _barcodeEvent(BarcodeEvent event, Emitter<InventoryBarcodeState> emit){
    emit(BarcodeState(barcode: event.barcode));
  }
}