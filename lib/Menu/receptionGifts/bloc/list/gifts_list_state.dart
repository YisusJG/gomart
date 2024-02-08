import '../../models/reception_gifts_model.dart';

class GiftsListState{
  final List<ReceptionGiftsModel> receptionGifts;

  GiftsListState({
    required this.receptionGifts,
  });
}

class ListState extends GiftsListState{
  ListState({
    required super.receptionGifts
  });
}