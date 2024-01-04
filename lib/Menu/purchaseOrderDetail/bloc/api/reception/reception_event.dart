import 'package:gomart/Menu/purchaseOrderDetail/models/reception_model.dart';

import '../../../models/reception_detail_model.dart';

class ReceptionEvent{}

class SaveReceptionEvent extends ReceptionEvent{
  final ReceptionModel receptionModel;

  SaveReceptionEvent({required this.receptionModel});
}

class SaveReceptionDetailsEvent extends ReceptionEvent{
  final List<ReceptionDetailModel> details;

  SaveReceptionDetailsEvent({required this.details});
}