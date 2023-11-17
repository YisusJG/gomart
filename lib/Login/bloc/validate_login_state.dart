import 'package:gomart/Login/models/employee_model.dart';

abstract class ValidateLoginState {
  EmployeeModel? employeeModel;
  String errorApi;

  ValidateLoginState({
    this.employeeModel,
    this.errorApi = ""});
}

class StartValidateLogin extends ValidateLoginState{
  StartValidateLogin({required EmployeeModel? employeeModel}) : super(employeeModel: employeeModel);
}

class LoadValidateLogin extends ValidateLoginState{
  LoadValidateLogin({required EmployeeModel? employeeModel}) : super(employeeModel: employeeModel);
}

class ErrorLoadValidateLogin extends ValidateLoginState{
  ErrorLoadValidateLogin({required String error}) : super(errorApi: error);
}
