import 'package:floor/floor.dart';
import 'package:gomart/DataBase/entities/branch_entity.dart';
import 'package:gomart/DataBase/entities/ip_gomart_entity.dart';

@dao
abstract class BranchDao{

  @Insert()
  Future<void>insertBranch(BranchEntity branch);

   @Query('SELECT * FROM BranchEntity')
  Future<BranchEntity?>findBranch();

  @Query('SELECT * FROM BranchEntity')
  Future<List<BranchEntity>>findAllBranch();

  @Query('DELETE FROM BranchEntity')
  Future<BranchEntity?>deleteBranch();

}