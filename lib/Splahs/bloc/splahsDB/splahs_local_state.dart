abstract class SplahsLocalState{
  bool isLocalEmployee;

  SplahsLocalState({this.isLocalEmployee = false});
}

class LocalEmployeeLoadingState extends SplahsLocalState{
  LocalEmployeeLoadingState({required super.isLocalEmployee});

}