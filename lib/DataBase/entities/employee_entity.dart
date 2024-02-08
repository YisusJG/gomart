
import 'package:floor/floor.dart';

import '../../Menu/Login/models/employee_model.dart';

@entity
class EmployeeEntity{
  @primaryKey
  late int id;
  late int branchId;
  late String employeeNumber;
  late String name;
  late String lastName;
  late String mothersLastName;
  late String? photo;
  late String corporateEmail;

  EmployeeEntity({
    this.id = 0,
    this.branchId = 0,
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
      branchId: data.branchId,
      employeeNumber: data.employeeNumber,
      name: data.name,
      lastName:  data.lastName,
      mothersLastName: data.mothersLastName,
      photo: data.photo,
      corporateEmail: data.corporateEmail,
    );
  }

  EmployeeEntity.fromMap(Map<String, dynamic> map)
    : id = map["id"],
      branchId = map["branchId"],
      employeeNumber = map["employeeNumber"],
      name = map["name"],
      lastName = map["lastName"],
      mothersLastName = map["mothersLastName"],
      photo = map["photo"],
      corporateEmail = map["corporateEmail"];

  Map<String, dynamic> employeeEntityToMap() {
    return {
      'id': id,
      'branchId' : branchId,
      'employeeNumber' : employeeNumber,
      'name' : name,
      'lastName' : lastName,
      'mothersLastName' : mothersLastName,
      'photo' : photo,
      'corporateEmail' : corporateEmail,
    };
  }

}