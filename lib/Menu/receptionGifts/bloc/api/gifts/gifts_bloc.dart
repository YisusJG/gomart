import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/receptionGifts/bloc/api/gifts/gifts_event.dart';
import 'package:gomart/Menu/receptionGifts/bloc/api/gifts/gifts_state.dart';
import 'package:gomart/Menu/receptionGifts/repository/gifts_repository.dart';

class GiftsBloc extends Bloc<GiftsEvent,GiftsState>{
  final GiftsRepository giftsRepository;

  GiftsBloc(this.giftsRepository): super (GiftsState()){
    on<SaveGiftsEvent>(_saveGiftsEvent);
  }

  void _saveGiftsEvent(SaveGiftsEvent event, Emitter<GiftsState> emit) async {
    try {
      final messageDetails = await giftsRepository.saveGifts(gifts: event.receptionGiftsModel);
      emit(SaveGiftsState(message: messageDetails.messaje));
    }catch (e) {
      emit(ErrorSaveGifts(errorApi: e.toString()));
    }
  }
}