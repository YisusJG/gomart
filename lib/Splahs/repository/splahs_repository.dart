import 'package:gomart/DataBase/entities/employee_entity.dart';

import '../../DataBase/db.dart';

class SplahsRepository{

  Future<List<EmployeeEntity>?> validateEmployee() async{
    final db = await DB.instance.database;
    final employee = await db?.employeeDao.findAllEmployee();
    return employee;
  }
}