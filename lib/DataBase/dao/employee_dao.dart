import 'package:floor/floor.dart';
import 'package:gomart/DataBase/entities/employee_entity.dart';

@dao
abstract class EmployeeDao{
  @Insert()
  Future<void> insertEmployee(EmployeeEntity employee);
  
  @Query('SELECT * FROM EmployeeEntity')
  Future<List<EmployeeEntity>> findAllEmployee();

  @Query('DELETE FROM EmployeeEntity')
  Future<EmployeeEntity?>deleteEmployee();

  @Query('SELECT * FROM EmployeeEntity')
  Future<EmployeeEntity?> findEmployee();
}