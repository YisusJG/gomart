
import 'package:floor/floor.dart';

import '../../Menu/Login/models/employee_model.dart';


@entity
class EmployeeEntity{
  @primaryKey
  late int id;
  late String employeeNumber;
  late String name;
  late String lastName;
  late String mothersLastName;
  late String? photo;
  late String corporateEmail;

  EmployeeEntity({
    this.id = 0,
    this.employeeNumber = "",
    this.name = "",
    this.lastName = "",
    this.mothersLastName = "",
    this.photo,
    this.corporateEmail="",

  });

  @override
  factory EmployeeEntity.fromEntity(EmployeeModel data) {
    return EmployeeEntity(
      id: data.id,
      employeeNumber: data.employeeNumber,
      name: data.name,
      lastName:  data.lastName,
      mothersLastName: data.mothersLastName,
      photo: data.photo,
      corporateEmail: data.corporateEmail,
    );
  }

}