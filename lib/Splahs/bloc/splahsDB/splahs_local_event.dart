abstract class SplahsLocalEvent{}

class ValidateEmployeeEvent extends SplahsLocalEvent{
  final bool? isLocalEmploye;
  ValidateEmployeeEvent({required this.isLocalEmploye});
}