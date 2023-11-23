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
}