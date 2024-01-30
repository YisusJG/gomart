import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/buttonSaveInventory/click_button_save_inventory_event.dart';
import 'package:gomart/Menu/inventory/bloc/buttonSaveInventory/click_button_save_inventory_state.dart';

class ClickButtonSaveInventoryBloc extends Bloc<ClickButtonSaveInventoryEvent, ClickButtonSaveInventoryState> {
  ClickButtonSaveInventoryBloc() : super(ClickButtonSaveInventoryState()) {
    on<ButtonSaveInventoryEvent>(_buttonSaveInventoryEvent);
  }

  void _buttonSaveInventoryEvent(ButtonSaveInventoryEvent event, Emitter<ClickButtonSaveInventoryState> emit){
    debugPrint("ClickButtonSaveInventory ${event.onClickSaveInventory}");
    emit(ButtonSaveInventoryState(onClick: event.onClickSaveInventory));

  }
}