import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gomart/Menu/receptionGifts/bloc/list/gifts_list_event.dart';
import 'package:gomart/Menu/receptionGifts/bloc/list/gifts_list_state.dart';

class GiftsListBloc extends Bloc<GiftsListEvent, GiftsListState>{

  GiftsListBloc():super(GiftsListState()){
    on<ListEvent>(_listEvent);
  }

  void _listEvent(ListEvent event, Emitter<GiftsListState> emit){
    emit(ListState(receptionGifts: event.receptionGifts));
  }
}