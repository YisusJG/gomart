import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/button/click_gift_event.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/button/click_gift_state.dart';

class ClickGiftBloc extends Bloc<ClickGiftEvent,ClickGiftState>{
  ClickGiftBloc() : super(ClickGiftState()){
    on<AddGiftsEvent>(_addGiftsEvent);
  }

  void _addGiftsEvent(AddGiftsEvent event, Emitter<ClickGiftState> emit){
    debugPrint("ir a regalo ${event.onClick}");
    emit(AddGiftState(onClick: event.onClick));
  }
}