abstract class DialogInputEvent{}

class ValidateInputDialogEvent extends DialogInputEvent{
  final bool isvalidateCost;
  final bool isValidaAmount;
  ValidateInputDialogEvent({
    required this.isvalidateCost,
    required this.isValidaAmount
  });
}