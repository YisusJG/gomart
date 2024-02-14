import '../../purchaseOrderDetail/models/ProductBarCodes.dart';

class ReceptionGiftsModel {

  int receptionId;
  int productId;
  int unitId;
  int quantity;
  double roundingValue;
  double unitPrice;
  double total;
  int branchId;
  bool visible;
  String insertDate;
  int insertUserId;
  String name;
  String sapmaterial;
  String nameUnit;
  String barcode;
  List<ProductBarCodes>? productBarCodes;

  ReceptionGiftsModel(
      {
        this.receptionId = 0,
        this.productId = 0,
        this.unitId = 0,
        this.quantity = 0,
        this.roundingValue = 0,
        this.unitPrice = 0,
        this.total = 0,
        this.branchId = 0,
        this.visible = true,
        this.insertDate = "",
        this.insertUserId = 0,
        this.name ="",
        this.sapmaterial = "",
        this.nameUnit = "",
        this.barcode = "",
        this.productBarCodes
      });

  factory ReceptionGiftsModel.fromJson(Map<String, dynamic> map) {
    return ReceptionGiftsModel(
    receptionId: map['receptionId'],
    productId: map['productId'],
    unitId: map['unitId'],
    quantity: map['quantity'],
    roundingValue: map['roundingValue'],
    unitPrice: map['unitPrice'],
    total: map['total'],
    branchId: map['branchId'],
    visible: map['visible'],
    insertDate: map['insertDate'],
    insertUserId: map['insertUserId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['receptionId'] = receptionId;
    data['productId'] = productId;
    data['unitId'] = unitId;
    data['quantity'] = quantity;
    data['roundingValue'] = roundingValue;
    data['unitPrice'] = unitPrice;
    data['total'] = total;
    data['branchId'] = branchId;
    data['visible'] = visible;
    data['insertDate'] = insertDate;
    data['insertUserId'] = insertUserId;
    return data;
  }
}