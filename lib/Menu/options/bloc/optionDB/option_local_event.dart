import 'package:gomart/DataBase/entities/branch_entity.dart';

abstract class  OptionLocalEvent{}

class GetBranchEvent extends OptionLocalEvent{
  final BranchEntity? branchEntity;
  GetBranchEvent({required this.branchEntity});
}