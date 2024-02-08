import '../../models/employee_model.dart';

abstract class ValidateLoginState {
  EmployeeModel? employeeModel;
  String errorApi;

  ValidateLoginState({
    this.employeeModel,
    this.errorApi = ""});
}

class StartValidateLogin extends ValidateLoginState{
  StartValidateLogin({required super.employeeModel});
}

class LoadValidateLoginState extends ValidateLoginState{
  LoadValidateLoginState({required super.employeeModel});
}

class ErrorLoadValidateLogin extends ValidateLoginState{
  ErrorLoadValidateLogin({required String error}) : super(errorApi: error);
}
