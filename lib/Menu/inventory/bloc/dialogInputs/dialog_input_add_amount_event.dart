abstract class DialogInputAddAmountEvent{}

class ValidateInputAddAmountEvent extends DialogInputAddAmountEvent{
  final bool isValidAmount;
  ValidateInputAddAmountEvent({required this.isValidAmount});
}