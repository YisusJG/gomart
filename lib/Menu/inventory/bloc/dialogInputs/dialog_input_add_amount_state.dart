class DialogInputAddAmountState{
  final bool isValidAmount;
  DialogInputAddAmountState({
    this.isValidAmount = false
});
}

class ValidateInputAddAmountState extends DialogInputAddAmountState{
  ValidateInputAddAmountState({
    required super.isValidAmount
});
}
