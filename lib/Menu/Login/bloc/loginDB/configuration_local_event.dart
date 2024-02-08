import 'package:gomart/ConnectionToGomart/models/branch_model.dart';

import '../../models/employee_model.dart';

abstract class ConfigurationLocalEvent{}

class SaveEmployeeEvent extends ConfigurationLocalEvent{
  final EmployeeModel employeeModel;
  SaveEmployeeEvent({required this.employeeModel});
}

class SaveBranchEvent extends ConfigurationLocalEvent{
  final BranchModel branchModel;
  SaveBranchEvent({required this.branchModel});
}