
import 'package:gomart/ConnectionToGomart/models/branch_model.dart';
import 'package:gomart/Menu/Login/models/employee_model.dart';
import 'package:gomart/Menu/inventory/model/branch_inventory_model.dart';
import 'package:gomart/Menu/inventory/model/branch_inventory_product_model.dart';

class BranchInventoryEvent{}

class SaveBranchInventoryEvent extends BranchInventoryEvent{
  final BranchInventoryModel branchInventoryModel;

  SaveBranchInventoryEvent({required this.branchInventoryModel});
}

class SaveBranchInventoryProductEvent extends BranchInventoryEvent{
  final List<BranchInventoryProductModel> branchInventoryProductModel;

  SaveBranchInventoryProductEvent({required this.branchInventoryProductModel});
}

class GetEmployeeInfoEvent extends BranchInventoryEvent{
  final EmployeeModel? employeeModel;
  GetEmployeeInfoEvent({required this.employeeModel});
}

class GetBranchInventoryEvent extends BranchInventoryEvent{
  final BranchModel? branchModel;
  GetBranchInventoryEvent({required this.branchModel});
}


