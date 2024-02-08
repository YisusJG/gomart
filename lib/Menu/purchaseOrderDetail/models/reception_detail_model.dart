import 'package:gomart/Menu/purchaseOrderDetail/models/purchase_order_detail_model.dart';

import 'ProductBarCodes.dart';

class ReceptionDetailModel {
  int receptionId;
  int productId;
  int unitId;
  int poquantity;
  String lessQuantityNotes;
  int quantity;
  double roundingValue;
  double unitPrice;
  double subtotal;
  double iva;
  double ieps;
  double discount;
  double total;
  int branchId;
  int insertUserId;
  double pounitPrice;
  String productName;
  String? barcode;
  String insertDate;
  bool visible;
  int expiration;
  bool isReceived;
  List<ProductBarCodes>? productBarCodes;

  ReceptionDetailModel(
      {
        this.receptionId = 0,
        this.productId = 0,
        this.unitId = 0,
        this.poquantity = 0,
        this.lessQuantityNotes = "",
        this.quantity = 0,
        this.roundingValue = 0.0,
        this.unitPrice = 0.0,
        this.subtotal = 0.0,
        this.iva = 0.0,
        this.ieps = 0.0,
        this.discount = 0.0,
        this.total = 0.0,
        this.branchId = 0,
        this.insertUserId = 1,
        this.pounitPrice = 0.0,
        this.productName = "",
        this.barcode,
        this.insertDate = "",
        this.visible = true,
        this.expiration = 0,
        this.isReceived = false,
        this.productBarCodes,
      });

  factory ReceptionDetailModel.fromJson(Map<String, dynamic> map) {
    return ReceptionDetailModel(
        receptionId: map['receptionId'],
        productId: map['productId'],
        unitId: map['unitId'],
        poquantity: map['poquantity'],
        lessQuantityNotes: map['lessQuantityNotes'],
        quantity: map['quantity'],
        roundingValue: map['roundingValue'],
        unitPrice: map['unitPrice'],
        subtotal: map['subtotal'],
        iva: map['iva'],
        ieps: map['ieps'],
        discount: map['discount'],
        total: map['total'],
        branchId: map['branchId'],
        insertUserId: map['insertUserId'],
        pounitPrice: map['pounitPrice'],
        insertDate: map['insertDate'],
        visible: map['visible'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['receptionId'] = receptionId;
    data['productId'] = productId;
    data['unitId'] = unitId;
    data['poquantity'] = poquantity;
    data['lessQuantityNotes'] = lessQuantityNotes;
    data['quantity'] = quantity;
    data['roundingValue'] = roundingValue;
    data['unitPrice'] = unitPrice;
    data['subtotal'] = subtotal;
    data['iva'] = iva;
    data['ieps'] = ieps;
    data['discount'] = discount;
    data['total'] = total;
    data['branchId'] = branchId;
    data['insertUserId'] = insertUserId;
    data['pounitPrice'] = pounitPrice;
    data['insertDate'] = insertDate;
    data['visible'] = visible;
    return data;
  }

  @override
  factory ReceptionDetailModel.fromList(PurchaseOrderDetailModel data) {
    return ReceptionDetailModel(
      productId: data.productId,
      unitId: data.unitId,
      poquantity: data.quantity,
      pounitPrice: data.unitPrice,
    );
  }
}
