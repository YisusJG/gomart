class ClickButtonState{
  final void Function()? onClick;

  ClickButtonState({
     this.onClick
  });
}

class ClickState extends ClickButtonState{
  ClickState({required super.onClick});
}