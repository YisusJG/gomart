import 'package:gomart/Menu/inventory/model/branch_inventory_id.dart';

class BranchInventoryState {
  BranchInventoryId? branchInventoryId;
  String errorApi;
  String message;

  BranchInventoryState({
    this.branchInventoryId,
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

class ErrorSaveBranchProductInventory extends BranchInventoryState {
  ErrorSaveBranchProductInventory({required super.errorApi});
}

