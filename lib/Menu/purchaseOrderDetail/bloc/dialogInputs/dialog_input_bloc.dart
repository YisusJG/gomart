import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/dialogInputs/dialog_input_event.dart';
import 'package:gomart/Menu/purchaseOrderDetail/bloc/dialogInputs/dialog_input_state.dart';

class DialogInputBloc extends Bloc<DialogInputEvent, DialogInputState>{
  DialogInputBloc():super(DialogInputState()){
    on<ValidateInputDialogEvent>(_dialogInputEvent);
  }

  void _dialogInputEvent(ValidateInputDialogEvent event, Emitter<DialogInputState> emit){
    print("Validation ${event.isvalidateCost}");
    emit(ValidateInputDialogState(isvalidateCost: event.isvalidateCost, isValidateAmount: event.isValidaAmount));
  }
}

