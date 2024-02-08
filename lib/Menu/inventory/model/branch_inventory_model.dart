class BranchInventoryModel {
  String name;
  int? inventoryId;
  int productCategoryId;
  int branchId;
  int branchInventoryStatusId;
  bool haveDifferences;
  bool visible;
  int insertUserId;

  BranchInventoryModel({
    this.name = "",
    this.inventoryId,
    this.productCategoryId = 0,
    this.branchId = 0,
    this.branchInventoryStatusId = 0,
    this.haveDifferences = false,
    this.visible = false,
    this.insertUserId = 0
  });

  factory BranchInventoryModel.fromJson(Map<String, dynamic> map){
    return BranchInventoryModel(
      name: map["name"],
      inventoryId: map["inventoryId"],
      productCategoryId: map["productCategoryId"],
      branchId: map["branchId"],
      branchInventoryStatusId: map["branchInventoryStatus"],
      haveDifferences: map["haveDifferences"],
      visible: map["visible"],
      insertUserId: map["insertUserId"]
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['inventoryId'] = inventoryId;
    data['productCategoryId'] = productCategoryId;
    data['branchId'] = branchId;
    data['branchInventoryStatusId'] = branchInventoryStatusId;
    data['haveDifferences'] = haveDifferences;
    data['visible'] = visible;
    data['insertUserId'] = insertUserId;
    return data;
  }
}