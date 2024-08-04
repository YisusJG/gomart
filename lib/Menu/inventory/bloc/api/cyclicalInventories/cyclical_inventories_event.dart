
abstract class CyclicalInventoriesEvent{}

class LoadCyclicalInventoriesEvent extends CyclicalInventoriesEvent{
  LoadCyclicalInventoriesEvent();
}

class LoadProductsCyclicalInventoryEvent extends CyclicalInventoriesEvent{
  final int cyclicalInventoryId;
  LoadProductsCyclicalInventoryEvent({required this.cyclicalInventoryId});
} //