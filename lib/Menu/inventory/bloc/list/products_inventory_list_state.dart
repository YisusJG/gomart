import 'package:gomart/Menu/inventory/model/product_model.dart';

class ProductsInventoryListState{
  final List<ProductModel>? listProductModel;

  ProductsInventoryListState({
    this.listProductModel
});
}

class ListProductModelState extends ProductsInventoryListState{
  ListProductModelState({required super.listProductModel});
}