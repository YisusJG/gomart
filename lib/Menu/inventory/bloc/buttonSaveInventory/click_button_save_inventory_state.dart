class ClickButtonSaveInventoryState{
  final void Function()? onClick;

  ClickButtonSaveInventoryState({
    this.onClick
  });
}

class ButtonSaveInventoryState extends ClickButtonSaveInventoryState{
  ButtonSaveInventoryState({required super.onClick});
}