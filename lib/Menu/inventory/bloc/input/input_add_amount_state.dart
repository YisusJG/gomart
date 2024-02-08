import '../../model/product_model.dart';

class InputAddAmountState{
  final int id;
  final int amount;

  InputAddAmountState({this.id = 0, this.amount = 0});
}

class InputAmountState extends InputAddAmountState {
  InputAmountState({required super.id, required super.amount});
}