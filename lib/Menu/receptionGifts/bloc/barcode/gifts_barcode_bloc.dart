import 'package:flutter_bloc/flutter_bloc.dart';

import 'gifts_barcode_event.dart';
import 'gifts_barcode_state.dart';

class GiftsBarcodeBloc extends Bloc<GiftsBarcodeEvent, GiftsBarcodeState>{
  static get barcode => '';

  GiftsBarcodeBloc():super(BarcodeGiftsState(barcode: barcode)){
    on<BarcodeGiftsEvent>(_barcodeEvent);
  }

  void _barcodeEvent(BarcodeGiftsEvent event, Emitter<GiftsBarcodeState> emit){
    emit(BarcodeGiftsState(barcode: event.barcode));
  }
}