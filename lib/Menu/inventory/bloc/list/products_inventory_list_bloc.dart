
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/inventory/bloc/list/products_inventory_list_event.dart';
import 'package:gomart/Menu/inventory/bloc/list/products_inventory_list_state.dart';

class ProductsInventoryListBloc extends Bloc<ProductsInventoryListEvent, ProductsInventoryListState>{
  ProductsInventoryListBloc() : super(ProductsInventoryListState()){
    on<ListProductModelEvent>(_listProductModelEvent);
  }
}

void _listProductModelEvent(ListProductModelEvent event, Emitter<ProductsInventoryListState> emit) {
  emit(ListProductModelState(listProductModel: event.listProductModel));
}