import 'package:gomart/Menu/receptionGifts/models/reception_gifts_model.dart';

abstract class GiftsEvent{}

class SaveGiftsEvent extends GiftsEvent{
  final List<ReceptionGiftsModel>receptionGiftsModel;

  SaveGiftsEvent({required this.receptionGiftsModel});
}