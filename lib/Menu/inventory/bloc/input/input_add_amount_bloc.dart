import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/input/input_add_amount_event.dart';
import 'package:gomart/Menu/inventory/bloc/input/input_add_amount_state.dart';

class InputAddAmountBloc extends Bloc<InputAddAmountEvent, InputAddAmountState>{

  InputAddAmountBloc() : super(InputAddAmountState()){
    on<InputAmountEvent>(_onInputAmountEvent);
  }

  void _onInputAmountEvent(InputAmountEvent event, Emitter<InputAddAmountState> emit) {
    emit(InputAmountState(id: event.id ,amount: event.amount));
  }
}