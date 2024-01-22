abstract class ClickButtonEvent{}

class ClickEvent extends ClickButtonEvent{
  final void Function()? onClick;

  ClickEvent({
     this.onClick
  });
}