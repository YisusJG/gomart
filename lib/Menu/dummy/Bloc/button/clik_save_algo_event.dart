abstract class ClickSaveAlgoEvent{}

class ClickSaveEvent extends ClickSaveAlgoEvent{
  final void Function()? onClick;

  ClickSaveEvent({
    this.onClick
  });
}