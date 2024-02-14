import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/receptionGifts/bloc/api/products/supplier_products_event.dart';
import 'package:gomart/Menu/receptionGifts/bloc/api/products/supplier_products_state.dart';
import 'package:gomart/Menu/receptionGifts/models/reception_gifts_model.dart';
import 'package:gomart/Menu/receptionGifts/repository/gifts_repository.dart';

import '../../../models/product_provider_model.dart';

class SupplierProductsBloc extends Bloc<SupplierProductsEvent, SupplierProductsState>{
  final GiftsRepository giftsRepository;
  static get productProvider => null;

  SupplierProductsBloc(this.giftsRepository): super(SupplierProductsState()){
    on<LoadSupplierProductsEvent>(_loadSupplierProductsEvent);
  }
  void _loadSupplierProductsEvent(LoadSupplierProductsEvent event, Emitter<SupplierProductsState> emit) async{
   // print("Entra");
    //Probar que traiga los datos
    try{
      emit(StartingSupplierProductsState(lsReceptionGifts: productProvider));
      List<ProductProviderModel> productsProvider = await giftsRepository.getSupplierProducts(providerId: event.providerId);
      List<ReceptionGiftsModel> receptionGifts = productsProvider.map((ProductProviderModel productProviderModel){
        return ReceptionGiftsModel(
          productId: productProviderModel.productId,
          unitId: productProviderModel.unitId,
          roundingValue: productProviderModel.roundingValue,
          name: productProviderModel.name,
          quantity: productProviderModel.quantity,
          nameUnit: productProviderModel.nameUnit,
          sapmaterial: productProviderModel.sapmaterial,
          barcode: productProviderModel.barcode,
          productBarCodes: productProviderModel.productBarCodes
        );
      }).toList();
      emit(LoadSupplierProductsState(lsReceptionGifts: receptionGifts));

    }catch(e){
      emit(ErrorSupplierProductsState(errorApi: e.toString()));
    }
  }
}