import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'click_button_save_inventory_event.dart';
import 'click_button_save_inventory_state.dart';

class ClickButtonSaveInventoryBloc extends Bloc<ClickButtonSaveInventoryEvent, ClickButtonSaveInventoryState> {
  ClickButtonSaveInventoryBloc() : super(ClickButtonSaveInventoryState()) {
    on<ButtonSaveInventoryEvent>(_buttonSaveInventoryEvent);
  }

  void _buttonSaveInventoryEvent(ButtonSaveInventoryEvent event, Emitter<ClickButtonSaveInventoryState> emit){
    emit(ButtonSaveInventoryState(onClick: event.onClickSaveInventory));

  }
}