abstract class ClickButtonSaveInventoryEvent{}

class ButtonSaveInventoryEvent extends ClickButtonSaveInventoryEvent{
  final void Function()? onClickSaveInventory;

  ButtonSaveInventoryEvent({
    this.onClickSaveInventory
  });
}