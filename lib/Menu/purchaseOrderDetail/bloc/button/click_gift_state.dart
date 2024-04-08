class ClickGiftState{
  final void Function()? onClick;

  ClickGiftState({
    this.onClick
  });
}

class AddGiftState extends ClickGiftState{
  AddGiftState({required super.onClick});
}