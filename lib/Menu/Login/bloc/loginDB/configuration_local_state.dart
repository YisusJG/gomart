

abstract class ConfigurationLocalState{
  bool? isSavedEmployee ;
  bool? isSavedBranch;

  ConfigurationLocalState({this.isSavedEmployee, this.isSavedBranch});
}

class StartingSaveEmplopyeeState extends ConfigurationLocalState{
  StartingSaveEmplopyeeState({required super.isSavedEmployee});
}

class StartingSaveBranchState extends ConfigurationLocalState{
  StartingSaveBranchState({required super.isSavedBranch});
}