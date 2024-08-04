import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/api/cyclicalInventories/cyclical_inventories_event.dart';
import 'package:gomart/Menu/inventory/bloc/api/cyclicalInventories/cyclical_inventories_state.dart';
import 'package:gomart/Menu/inventory/repository/inventory_repository.dart';

class CyclicalInventoriesBloc extends Bloc<CyclicalInventoriesEvent, CyclicalInventoriesState> {
  final InventoryRepository inventoryRepository;

  static get cyclicalInventoriesModel => null;
  static get productsCyclicalInventoryModel => null;

  CyclicalInventoriesBloc(this.inventoryRepository) : super(CyclicalInventoriesState()){
    on<LoadCyclicalInventoriesEvent>(_cyclicalInventoriesEvent);
    on<LoadProductsCyclicalInventoryEvent>(_productsCyclicalInventoryEvent);
  }

  void _cyclicalInventoriesEvent(LoadCyclicalInventoriesEvent event, Emitter<CyclicalInventoriesState> emit) async {
    try {
      emit(StartCyclicalInventoriesState(cyclicalInventoryModel: cyclicalInventoriesModel));
      final cyclicalInventories = await inventoryRepository.getAllCyclicalInventories();
      emit(LoadCyclicalInventoriesState(cyclicalInventoryModel: cyclicalInventories));
    } catch (e) {
      emit(ErrorCyclicalInventoriesState(errorApi: e.toString()));
    }
  }

  void _productsCyclicalInventoryEvent(LoadProductsCyclicalInventoryEvent event, Emitter<CyclicalInventoriesState> emit) async {
    try {
      emit(StartProductsCyclicalInventoryState(cyclicalInventoryProductModel: productsCyclicalInventoryModel));
      final productsCyclicalInventory = await inventoryRepository.getAllProductsByCyclicalInventoryId(cyclicalInventoryId: event.cyclicalInventoryId);
      emit(LoadProductsCyclicalInventoryState(cyclicalInventoryProductModel: productsCyclicalInventory));
    } catch (e) {
      emit(ErrorProductsCyclicalInventoryState(errorApi: e.toString()));
    }
  }
}