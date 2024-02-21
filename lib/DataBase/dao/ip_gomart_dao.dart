import 'package:floor/floor.dart';
import '../entities/ip_gomart_entity.dart';

@dao
abstract class IpGomartDao {

  @Insert()
  Future<void>insertIpGomart(IpGomartEntity ipGomartEntity);

  @Query('SELECT * FROM IpGomartEntity')
  Future<IpGomartEntity?>findIpGomart();

  @Query('DELETE FROM IpGomartEntity')
  Future<IpGomartEntity?>deleteIpGomart();

}
