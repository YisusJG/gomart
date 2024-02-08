import '../../../model/product_model.dart';

class ProductsByCategoryState{
  List<ProductModel>? productModel;
  String errorApi;

  ProductsByCategoryState({
    this.productModel,
    this.errorApi = ""
  });
}

class StartingProductsByCategory extends ProductsByCategoryState{
  StartingProductsByCategory({required super.productModel});
}

class LoadProductsByCategory extends ProductsByCategoryState{
  LoadProductsByCategory({required super.productModel});
}

class ErrorLoadingProductsByCategory extends ProductsByCategoryState{
  ErrorLoadingProductsByCategory({required super.errorApi});
}