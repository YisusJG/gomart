import 'package:gomart/DataBase/entities/branch_entity.dart';

import '../../../DataBase/db.dart';

class OptionsRepository{

  Future<List<BranchEntity>?> getBranch() async{
    final db = await DB.instance.database;
    final branch = await db?.branchDao.findAllBranch();
    return branch;
  }
}