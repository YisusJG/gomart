abstract class LoginInputState {
  String user;
  String password;
  LoginInputState({
    this.user = '',
    this.password = '',

  });
}

class LoginState extends LoginInputState{
  LoginState({
    required  super.user,
    required  super.password,
  });
}
