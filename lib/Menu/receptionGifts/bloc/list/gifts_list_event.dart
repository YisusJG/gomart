import '../../models/reception_gifts_model.dart';

abstract class GiftsListEvent{}

class ListEvent extends GiftsListEvent {
  final List<ReceptionGiftsModel>? receptionGifts;
  ListEvent({
    this.receptionGifts
  });
}