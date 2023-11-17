import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Login/bloc/validate_login_event.dart';
import 'package:gomart/Login/bloc/validate_login_state.dart';
import 'package:gomart/Login/repository/login_repository.dart';

class ValidateLoginBloc extends Bloc<LoadValidateLoginEvent, ValidateLoginState>{
  final LoginRepository loginRepository;

  ValidateLoginBloc(this.loginRepository) : super(StartValidateLogin(employeeModel: null)){
    on<LoadValidateLoginEvent>(_loginLoadEvent);
  }

  void _loginLoadEvent(LoadValidateLoginEvent event, Emitter<ValidateLoginState> emit) async{
    try {
      emit(StartValidateLogin(employeeModel: null));
      print("llega ${event.user} y ${event.password}");
      final login = await loginRepository.getUser(user: event.user, password: event.password);
      emit(LoadValidateLogin(employeeModel: login));
    } catch (e) {
      emit(ErrorLoadValidateLogin(error: e.toString()));
    }
  }
}