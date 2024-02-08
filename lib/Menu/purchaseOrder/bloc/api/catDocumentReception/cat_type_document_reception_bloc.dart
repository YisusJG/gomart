import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/purchaseOrder/bloc/api/catDocumentReception/cat_type_document_reception_event.dart';
import 'package:gomart/Menu/purchaseOrder/bloc/api/catDocumentReception/cat_type_document_reception_state.dart';

import '../../../repository/purchase_order_repository.dart';

class CatTypeDocumentReceptionBloc extends Bloc<CatTypeDocumentReceptionEvent, CatTypeDocumentReceptionState>{
  final PurchaseOrderRepository purchaseOrderRepository;
  static get typeDocument => null;

  CatTypeDocumentReceptionBloc(this.purchaseOrderRepository) :super(CatTypeDocumentReceptionState()){
    on<LoadDocumentReception>(_documentReceptionEvent);
  }

  void _documentReceptionEvent(LoadDocumentReception event, Emitter<CatTypeDocumentReceptionState> emit)async{
    try{
      //print('Recupera tipo de docuentos');
      emit(StartingDocumentReceptionState(typeDocument: typeDocument));
      final typeDocumentReception = await purchaseOrderRepository.getAllTypeDocumentReceptions();
      emit(LoadDocumentReceptionState(typeDocument: typeDocumentReception));
    }catch(e){
      emit(ErrorLoadingDocumentReceptionState(errorApi: e.toString()));
    }
  }

}