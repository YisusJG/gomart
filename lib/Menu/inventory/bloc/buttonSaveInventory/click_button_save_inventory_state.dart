import 'dart:ui';

class ClickButtonSaveInventoryState{
  final VoidCallback? onClick;

  ClickButtonSaveInventoryState({
    this.onClick
  });
}

class ButtonSaveInventoryState extends ClickButtonSaveInventoryState{
  ButtonSaveInventoryState({required super.onClick});
}