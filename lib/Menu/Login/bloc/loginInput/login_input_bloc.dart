import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_input_event.dart';
import 'login_input_state.dart';

class LoginInputBloc extends Bloc<LoginInputEvent, LoginInputState>{
  LoginInputBloc():super(LoginState(user: '',password: '')){
    on<LoginEvent>(_loginEvent);
  }

  void _loginEvent(LoginEvent event, Emitter<LoginInputState> emit){
    emit(LoginState(user: event.user, password: event.password));
  }
}
