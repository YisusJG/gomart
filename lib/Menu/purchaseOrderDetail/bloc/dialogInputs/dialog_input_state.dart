class DialogInputState{
  final bool isvalidateCost;
  final bool isValidateAmount;
  DialogInputState({
    this.isvalidateCost = false,
    this.isValidateAmount = false,
  });
}

class ValidateInputDialogState extends DialogInputState{
  ValidateInputDialogState({
    required super.isvalidateCost,
    required super.isValidateAmount,
  });
}