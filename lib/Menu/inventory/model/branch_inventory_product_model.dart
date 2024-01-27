class BranchInventoryProductModel {
  int branchInventoriesId;
  int branchId;
  int productId;
  int count;
  bool visible;
  int insertUserId;

  BranchInventoryProductModel({
    this.branchInventoriesId = 0,
    this.branchId = 0,
    this.productId = 0,
    this.count = 0,
    this.visible = false,
    this.insertUserId = 0
  });

  factory BranchInventoryProductModel.fromJson(Map<String, dynamic> map){
    return BranchInventoryProductModel(
      branchInventoriesId: map["branchInventoriesId"],
      branchId: map["branchId"],
      productId: map["productId"],
      count: map["count"],
      visible: map["visible"],
      insertUserId: map["insertUserId"]
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['branchInventoriesId'] = branchInventoriesId;
    data['branchId'] = branchId;
    data['productId'] = productId;
    data['count'] = count;
    data['visible'] = visible;
    data['insertUserId'] = insertUserId;
    return data;
  }
}