import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/dialogInputs/dialog_input_add_amount_event.dart';
import 'package:gomart/Menu/inventory/bloc/dialogInputs/dialog_input_add_amount_state.dart';

class DialogInputAddAmountBloc extends Bloc<DialogInputAddAmountEvent, DialogInputAddAmountState>{
  DialogInputAddAmountBloc() : super(DialogInputAddAmountState()){
    on<ValidateInputAddAmountEvent>(_dialogInputAddAmountEvent);
  }

  void _dialogInputAddAmountEvent(ValidateInputAddAmountEvent event, Emitter<DialogInputAddAmountState> emit) {
    print("Validation ${event.isValidAmount}");
    emit(ValidateInputAddAmountState(isValidAmount: event.isValidAmount));
  }
}