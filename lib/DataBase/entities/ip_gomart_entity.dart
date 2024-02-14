import 'package:floor/floor.dart';
import '../../ConnectionToGomart/models/ip_gomart_modal.dart';

@entity
class IpGomartEntity{

  @PrimaryKey(autoGenerate: true)
  late int id;
  late String ip;

  IpGomartEntity({
    this.id = 0,
    this.ip = ""
  });

  factory IpGomartEntity.fromEntity(IpGomartModal data){
    return IpGomartEntity(
      id: data.id,
      ip: data.ip,
    );
  }

  IpGomartEntity.fromMap(Map<String, dynamic> map)
    :
        id = map["id"],
        ip = map["ip"];

  Map<String, dynamic> ipGomartEntityToMap() {
    return {
      'id': id,
      'ip' : ip
    };
  }
}