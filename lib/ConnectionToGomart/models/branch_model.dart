class BranchModel{
  late int id;
  late String zoneName;
  late String branchNumber;
  late String ip;
  late String description;

  BranchModel({
    this.id = 0,
    this.zoneName = "",
    this.branchNumber = "",
    this.ip = "",
    this.description ="",
  });

  factory BranchModel.fromJson(Map<String, dynamic> map) {
    return BranchModel(
      id: map['id'],
      zoneName: map['zoneName'],
      branchNumber: map['branchNumber'],
      ip: map['ip'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['zoneName'] = zoneName;
    data['branchNumber'] = branchNumber;
    data['ip'] = ip;
    data['description'] = description;
    return data;
  }
}