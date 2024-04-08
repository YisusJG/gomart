abstract class ClickGiftEvent{}

class AddGiftsEvent extends ClickGiftEvent{
  final void Function()? onClick;

  AddGiftsEvent({
    this.onClick
  });
}