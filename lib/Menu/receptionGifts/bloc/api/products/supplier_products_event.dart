abstract class SupplierProductsEvent{}

class LoadSupplierProductsEvent extends SupplierProductsEvent{
  final int providerId;
  LoadSupplierProductsEvent({this.providerId = 0});
}