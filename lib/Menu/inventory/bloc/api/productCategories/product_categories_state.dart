import '../../../model/product_category_model.dart';

final class ProductCategoriesState{
  List<ProductCategoryModel>? productCategoryModel;
  String errorApi;

  ProductCategoriesState({
    this.productCategoryModel,
    this.errorApi = ""
  });
}

final class StartingProductCategoryState extends ProductCategoriesState{
  StartingProductCategoryState({required super.productCategoryModel});
}

final class LoadProductCategoryState extends ProductCategoriesState{
  LoadProductCategoryState({required super.productCategoryModel});
}

final class ErrorLoadingProductCategoryState extends ProductCategoriesState{
  ErrorLoadingProductCategoryState({required super.errorApi});
}