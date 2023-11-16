import 'package:flutter_bloc/flutter_bloc.dart';

import 'ip_inputs_event.dart';
import 'ip_inputs_state.dart';

class IpInputsBloc extends Bloc<IpInputsEvent, IpInputsState>{
  IpInputsBloc():super(OctetsState(octetOne: '', octetTwo: '', octetThree: '', octetFour: '')){
    on<OctetsEvent>(_octetsEvent);
  }

  void _octetsEvent(OctetsEvent event, Emitter<IpInputsState> emit){
    emit(OctetsState(octetOne: event.octetOne, octetTwo: event.octetTwo, octetThree: event.octetThree, octetFour: event.octetFour));
  }
}
