import 'dart:async';
import 'package:floor/floor.dart';
import 'package:gomart/DataBase/dao/branch_dao.dart';
import 'package:gomart/DataBase/entities/branch_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/employee_dao.dart';
import 'entities/employee_entity.dart';
part 'gomart_db.g.dart';

@Database(version: 1, entities: [EmployeeEntity,BranchEntity])
abstract class AppDatabase extends FloorDatabase {
  EmployeeDao get employeeDao;
  BranchDao get branchDao;
}