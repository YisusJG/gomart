class BranchInventoryId {

  final int branchInventoryId;

  BranchInventoryId({
    this.branchInventoryId = 0
  });

  factory BranchInventoryId.fromJson(Map<String, dynamic> map) {
    return BranchInventoryId(
        branchInventoryId: map["id"]
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['branchInventoryId'] = branchInventoryId;
    return data;
  }

}