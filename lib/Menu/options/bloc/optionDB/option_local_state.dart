import 'package:gomart/DataBase/entities/branch_entity.dart';

abstract class OptionLocalState{
  BranchEntity? branchEntity;
  OptionLocalState({required this.branchEntity});
}

class LocalBranchLoadingState extends OptionLocalState{
  LocalBranchLoadingState({required super.branchEntity});
}