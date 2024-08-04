import 'package:gomart/Menu/inventory/model/cyclical_inventory_model.dart';
import 'package:gomart/Menu/inventory/model/cyclical_inventory_product_model.dart';

final class CyclicalInventoriesState{
  List<CyclicalInventoryModel>? cyclicalInventoryModel;
  List<CyclicalInventoryProductModel>? cyclicalInventoryProductModel;
  String errorApi;

  CyclicalInventoriesState({
    this.cyclicalInventoryModel,
    this.cyclicalInventoryProductModel,
    this.errorApi = ''
  });
}

final class StartCyclicalInventoriesState extends CyclicalInventoriesState{
  StartCyclicalInventoriesState({required super.cyclicalInventoryModel});
}

final class LoadCyclicalInventoriesState extends CyclicalInventoriesState{
  LoadCyclicalInventoriesState({required super.cyclicalInventoryModel});
}

final class ErrorCyclicalInventoriesState extends CyclicalInventoriesState{
  ErrorCyclicalInventoriesState({required super.errorApi});
}

final class StartProductsCyclicalInventoryState extends CyclicalInventoriesState{
  StartProductsCyclicalInventoryState({required super.cyclicalInventoryProductModel});
}

final class LoadProductsCyclicalInventoryState extends CyclicalInventoriesState{
  LoadProductsCyclicalInventoryState({required super.cyclicalInventoryProductModel});
}

final class ErrorProductsCyclicalInventoryState extends CyclicalInventoriesState{
  ErrorProductsCyclicalInventoryState({required super.errorApi});
}
