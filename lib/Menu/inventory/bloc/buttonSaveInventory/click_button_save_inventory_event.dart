abstract class ClickButtonSaveInventoryEvent{}

class ButtonSaveInventoryEvent extends ClickButtonSaveInventoryEvent{
  final void Function()? onClick;

  ButtonSaveInventoryEvent({
    this.onClick
  });
}