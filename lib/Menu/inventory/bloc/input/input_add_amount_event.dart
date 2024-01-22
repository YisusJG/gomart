import '../../model/product_model.dart';

class InputAddAmountEvent {
  const InputAddAmountEvent();
}

class InputAmountEvent extends InputAddAmountEvent{
  final int id;
  final int amount;

  InputAmountEvent({this.id = 0,this.amount = 0});
}