import '../../../model/product_category_model.dart';

final class ProductCategoriesState{
  List<ProductCategoryModel>? productCategoryModel;
  String errorApi;

  ProductCategoriesState({
    this.productCategoryModel,
    this.errorApi = ""
  });
}

final class StartingProductCategory extends ProductCategoriesState{
  StartingProductCategory({required super.productCategoryModel});
}

final class LoadProductCategory extends ProductCategoriesState{
  LoadProductCategory({required super.productCategoryModel});
}

final class ErrorLoadingProductCategory extends ProductCategoriesState{
  ErrorLoadingProductCategory({required super.errorApi});
}