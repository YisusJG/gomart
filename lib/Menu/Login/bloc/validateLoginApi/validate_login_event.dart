abstract class ValidateUserEvent{}

class LoadValidateLoginEvent extends ValidateUserEvent{
  final String user;
  final String password;
  LoadValidateLoginEvent({this.user = "", this.password = ""});
}