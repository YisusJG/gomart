import '../../model/product_model.dart';

abstract class ProductsInventoryListEvent{
  const ProductsInventoryListEvent();
}

class ListProductModelEvent extends ProductsInventoryListEvent{
  final List<ProductModel>? listProductModel;
  ListProductModelEvent({
    this.listProductModel
});
}