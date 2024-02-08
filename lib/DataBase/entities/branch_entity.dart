import 'package:floor/floor.dart';
import 'package:gomart/ConnectionToGomart/models/branch_model.dart';
@entity
class BranchEntity{
  @primaryKey
  late int id;
  late String zoneName;
  late String branchNumber;
  late String ip;
  late String description;

  BranchEntity({
    this.id = 0,
    this.zoneName = "",
    this.branchNumber = "",
    this.ip = "",
    this.description ="",
  });

  @override
  factory BranchEntity.fromEntity(BranchModel data) {
    return BranchEntity(
      id: data.id,
      zoneName: data.zoneName,
      branchNumber: data.branchNumber,
      ip: data.ip,
      description: data.description,
    );
  }

  BranchEntity.fromMap(Map<String, dynamic> map)
    : id = map["id"],
      zoneName = map["zoneName"],
      branchNumber = map["branchNumber"],
      ip = map["ip"],
      description = map["description"];

  Map<String, dynamic> branchEntityToMap() {
    return {
      'id' : id,
      'zoneName' : zoneName,
      'branchNumber' : branchNumber,
      'ip' : ip,
      'description' : description
    };
  }
}