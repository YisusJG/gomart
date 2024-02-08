import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/api/productsByCategory/products_by_category_event.dart';
import 'package:gomart/Menu/inventory/bloc/api/productsByCategory/products_by_category_state.dart';

import '../../../repository/inventory_repository.dart';

class ProductsByCategoryBloc extends Bloc<ProductsByCategoryEvent, ProductsByCategoryState> {
  final InventoryRepository inventoryRepository;

  ProductsByCategoryBloc(this.inventoryRepository) : super(ProductsByCategoryState()){
    on<LoadProductsByCategoryEvent>(_productsByCategoryEvent);
  }

  void _productsByCategoryEvent(LoadProductsByCategoryEvent event, Emitter<ProductsByCategoryState> emit) async {
    try{
      emit(StartingProductsByCategory(productModel: null));
      final products = await inventoryRepository.getAllProductsByCategoryId(categoryId: event.categoryId);
      emit(LoadProductsByCategory(productModel: products));
    }catch(e){
      emit(ErrorLoadingProductsByCategory(errorApi: e.toString()));
    }
  }
}