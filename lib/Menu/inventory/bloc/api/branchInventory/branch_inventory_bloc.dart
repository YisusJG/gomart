import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/api/branchInventory/branch_inventory_event.dart';
import 'package:gomart/Menu/inventory/bloc/api/branchInventory/branch_inventory_state.dart';
import 'package:gomart/Menu/inventory/model/branch_inventory_id.dart';

import '../../../repository/inventory_repository.dart';

class BranchInventoryBloc extends Bloc<BranchInventoryEvent, BranchInventoryState>{
  final InventoryRepository inventoryRepository;

  BranchInventoryBloc(this.inventoryRepository) : super(BranchInventoryState()){
   on<SaveBranchInventoryEvent>(_saveBranchInventoryEvent);
   on<SaveBranchInventoryProductEvent>(_saveBranchInventoryProductEvent);
  }

  void _saveBranchInventoryEvent(SaveBranchInventoryEvent event, Emitter<BranchInventoryState> emit) async {
    try{
      BranchInventoryId branchInventoryId = await inventoryRepository.saveBranchInventory(branchInventoryModel: event.branchInventoryModel);
      emit(SaveBranchInventoryState(branchInventoryId: branchInventoryId));
      debugPrint("BranchInventoryId 2 ${branchInventoryId.branchInventoryId}");
    } catch(e){
      emit(ErrorSaveBranchInventory(errorApi: e.toString()));
    }

  }

  void _saveBranchInventoryProductEvent(SaveBranchInventoryProductEvent event, Emitter<BranchInventoryState> emit) async {
    try{
      debugPrint("En el bloc ${event.branchInventoryProductModel.toList()}");
      debugPrint("En el bloc ${event.branchInventoryProductModel.length}");
      final messageSaveBranchInventoryProduct = await inventoryRepository.saveBranchInventoryProduct(branchInventoryProductModel: event.branchInventoryProductModel);
      emit(SaveBranchInventoryProductState(message: messageSaveBranchInventoryProduct.messaje));
    }catch(e){
      emit(ErrorSaveBranchProductInventory(errorApi: e.toString()));
    }
  }
}