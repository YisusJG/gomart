
import 'package:gomart/Menu/inventory/model/branch_inventory_model.dart';

class BranchInventoryEvent{}

class SaveBranchInventoryEvent extends BranchInventoryEvent{
  final BranchInventoryModel branchInventoryModel;

  SaveBranchInventoryEvent({required this.branchInventoryModel});
}

