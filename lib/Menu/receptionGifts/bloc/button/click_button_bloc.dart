import 'package:flutter_bloc/flutter_bloc.dart';

import 'click_button_event.dart';
import 'click_button_state.dart';

class ClickButtonBloc extends Bloc<ClickButtonEvent, ClickButtonState> {
  ClickButtonBloc() : super(ClickButtonState()){
    on<ClickEvent>(_clickEvent);
  }

  void _clickEvent(ClickEvent event, Emitter<ClickButtonState> emit){
    emit(ClickState(onClick: event.onClick));
  }
}