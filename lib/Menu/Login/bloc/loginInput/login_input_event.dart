abstract class LoginInputEvent {}

class LoginEvent extends LoginInputEvent{
  final String user;
  final String password;

  LoginEvent({
    required this.user,
    required this.password,
  });
}