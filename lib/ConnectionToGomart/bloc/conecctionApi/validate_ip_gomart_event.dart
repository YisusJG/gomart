import 'package:gomart/ConnectionToGomart/models/ip_gomart_modal.dart';

abstract class  ValidateIpGomartEvent{}

class LoadValidateIpGomartEvent extends ValidateIpGomartEvent{
  final String ipGomart;
  LoadValidateIpGomartEvent({this.ipGomart = ""});
}

class SaveIpGomartEvent extends ValidateIpGomartEvent{
  final IpGomartModal ipGomartModal;
  SaveIpGomartEvent({required this.ipGomartModal});
}