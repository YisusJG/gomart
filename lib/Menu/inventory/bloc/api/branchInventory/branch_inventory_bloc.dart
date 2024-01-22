import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/api/branchInventory/branch_inventory_event.dart';
import 'package:gomart/Menu/inventory/bloc/api/branchInventory/branch_inventory_state.dart';
import 'package:gomart/Menu/inventory/model/branch_inventory_id.dart';

import '../../../repository/inventory_repository.dart';

class BranchInventoryBloc extends Bloc<BranchInventoryEvent, BranchInventoryState>{
  final InventoryRepository inventoryRepository;

  BranchInventoryBloc(this.inventoryRepository) : super(BranchInventoryState()){
   on<SaveBranchInventoryEvent>(_saveBranchInventoryEvent);
  }

  void _saveBranchInventoryEvent(SaveBranchInventoryEvent event, Emitter<BranchInventoryState> emit) async {
    try{
      BranchInventoryId branchInventoryId = await inventoryRepository.saveBranchInventory(branchInventoryModel: event.branchInventoryModel);
      emit(SaveBranchInventoryState(branchInventoryId: branchInventoryId));
    } catch(e){
      emit(ErrorSaveBranchInventory(errorApi: e.toString()));
    }

  }
}