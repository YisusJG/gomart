import 'package:gomart/ConnectionToGomart/models/branch_model.dart';

abstract class ValidateIpGomartState{
  BranchModel? branch;
  String errorApi;

  ValidateIpGomartState({
    this.branch,
    this.errorApi = "",
  });
}

class StartingValidateIpGomart extends ValidateIpGomartState{
  StartingValidateIpGomart({required BranchModel? branchModel}) : super(branch: branchModel);
}

class LoadValidateIpGomartState extends ValidateIpGomartState{
  LoadValidateIpGomartState({required BranchModel? branchModel}) : super(branch: branchModel);
}

class ErrorLoadingValidateIpGomart extends ValidateIpGomartState{
  ErrorLoadingValidateIpGomart({required String error}) : super(errorApi: error);
}