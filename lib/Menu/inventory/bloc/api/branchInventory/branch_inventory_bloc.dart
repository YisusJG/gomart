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
   on<GetEmployeeInfoEvent>(_getEmployeeInfoEvent);
   on<GetBranchInventoryEvent>(_getBranchInventoryEvent);
  }

  void _saveBranchInventoryEvent(SaveBranchInventoryEvent event, Emitter<BranchInventoryState> emit) async {
    try{
      BranchInventoryId branchInventoryId = await inventoryRepository.saveBranchInventory(branchInventoryModel: event.branchInventoryModel);
      emit(SaveBranchInventoryState(branchInventoryId: branchInventoryId));
    } catch(e){
      emit(ErrorSaveBranchInventory(errorApi: e.toString()));
    }
  }

  void _saveBranchInventoryProductEvent(SaveBranchInventoryProductEvent event, Emitter<BranchInventoryState> emit) async {
    try{
      //debugPrint("En el bloc ${event.branchInventoryProductModel.toList()}");
      final messageSaveBranchInventoryProduct = await inventoryRepository.saveBranchInventoryProduct(branchInventoryProductModel: event.branchInventoryProductModel);
      emit(SaveBranchInventoryProductState(message: messageSaveBranchInventoryProduct.message));
    }catch(e){
      emit(ErrorSaveBranchProductInventoryState(errorApi: e.toString()));
    }
  }

  void _getEmployeeInfoEvent(GetEmployeeInfoEvent event, Emitter<BranchInventoryState> emit) async {
    debugPrint("algo");
    final employee = await inventoryRepository.getEmployeeInventory();
    emit(GetEmployeeInfoState(employeeModel: employee));

  }

  void _getBranchInventoryEvent(GetBranchInventoryEvent event, Emitter<BranchInventoryState> emit) async {
    final branch = await inventoryRepository.getBranchInventory();
    debugPrint("El branch name viene como ${branch?.toJson()}");
    emit(GetBranchInventoryState(branchModel: branch));
  }
}