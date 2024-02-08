class ClickSaveAlgoState{
  final void Function()? onClick;

  ClickSaveAlgoState({
    this.onClick
  });
}

class ClickSaveState extends ClickSaveAlgoState{
  ClickSaveState({required super.onClick});
}