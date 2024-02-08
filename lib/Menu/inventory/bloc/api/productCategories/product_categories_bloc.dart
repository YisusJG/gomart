import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/api/productCategories/product_cetegories_event.dart';
import 'package:gomart/Menu/inventory/bloc/api/productCategories/product_categories_state.dart';
import 'package:gomart/Menu/inventory/repository/inventory_repository.dart';

class ProductCategoriesBloc extends Bloc<ProductCategoriesEvent, ProductCategoriesState> {
  final InventoryRepository inventoryRepository;

  static get productCategoryModel => null;

  ProductCategoriesBloc(this.inventoryRepository) : super(ProductCategoriesState()){
    on<LoadProductCategoriesEvent>(_productCategoriesEvent);
  }

  void _productCategoriesEvent(LoadProductCategoriesEvent event, Emitter<ProductCategoriesState> emit) async {
    try {
      emit(StartingProductCategory(productCategoryModel: productCategoryModel));
      final productCategories = await inventoryRepository.getProductCategories();
      emit(LoadProductCategory(productCategoryModel: productCategories));
    }catch(e){
      emit(ErrorLoadingProductCategory(errorApi: e.toString()));
    }
  }
}