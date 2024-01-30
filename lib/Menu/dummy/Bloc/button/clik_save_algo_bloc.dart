import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/dummy/Bloc/button/clik_save_algo_event.dart';
import 'package:gomart/Menu/dummy/Bloc/button/clik_save_algo_state.dart';

class ClickSaveAlgoBloc extends Bloc<ClickSaveAlgoEvent,ClickSaveAlgoState>{
  ClickSaveAlgoBloc() : super(ClickSaveAlgoState()){
    on<ClickSaveEvent>(_clickSaveEvent);
  }

  void _clickSaveEvent(ClickSaveEvent event, Emitter<ClickSaveAlgoState> emit){
    debugPrint("${event.onClick}");
    emit(ClickSaveState(onClick: event.onClick));
  }
}