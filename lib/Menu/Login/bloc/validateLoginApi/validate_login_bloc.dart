import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/Login/bloc/validateLoginApi/validate_login_event.dart';
import 'package:gomart/Menu/Login/bloc/validateLoginApi/validate_login_state.dart';

import '../../../../DataBase/db.dart';
import '../../repository/login_repository.dart';

class ValidateLoginBloc extends Bloc<LoadValidateLoginEvent, ValidateLoginState>{
  final LoginRepository loginRepository;

  ValidateLoginBloc(this.loginRepository) : super(StartValidateLogin(employeeModel: null)){
    on<LoadValidateLoginEvent>(_loginLoadEvent);
  }

  void _loginLoadEvent(LoadValidateLoginEvent event, Emitter<ValidateLoginState> emit) async{
    try {
      emit(StartValidateLogin(employeeModel: null));
      debugPrint("llega ${event.user} y ${event.password}");
      final db = await DB.instance.database;
      final ipGomart = await db?.ipGomartDao.findIpGomart();
      debugPrint("La ip antes de login es ${ipGomart?.ip}");
      final login = await loginRepository.getUser(ip: "10.0.1.65",user: event.user, password: event.password);
      emit(LoadValidateLoginState(employeeModel: login));
    } catch (e) {
      emit(ErrorLoadValidateLogin(error: e.toString()));
    }
  }


}