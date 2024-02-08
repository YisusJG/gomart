import 'package:gomart/ConnectionToGomart/models/branch_model.dart';
import 'package:gomart/Menu/Login/models/employee_model.dart';
import 'package:gomart/Menu/inventory/model/branch_inventory_id.dart';

class BranchInventoryState {
  BranchInventoryId? branchInventoryId;
  BranchModel? branchModel;
  EmployeeModel? employeeModel;
  String errorApi;
  String message;

  BranchInventoryState({
    this.branchInventoryId,
    this.branchModel,
    this.employeeModel,
    this.errorApi = "",
    this.message = ""
  });

}

class SaveBranchInventoryState extends BranchInventoryState {
  SaveBranchInventoryState({required super.branchInventoryId});
}

class SaveBranchInventoryProductState extends BranchInventoryState {
  SaveBranchInventoryProductState({required super.message});
}

class ErrorSaveBranchInventory extends BranchInventoryState {
  ErrorSaveBranchInventory({required super.errorApi});
}

class ErrorSaveBranchProductInventoryState extends BranchInventoryState {
  ErrorSaveBranchProductInventoryState({required super.errorApi});
}

class GetEmployeeInfoState extends BranchInventoryState{
  GetEmployeeInfoState({required super.employeeModel});
}

class GetBranchInventoryState extends BranchInventoryState{
  GetBranchInventoryState({required super.branchModel});
}


