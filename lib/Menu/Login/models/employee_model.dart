class EmployeeModel{
  late int id;
  late String employeeNumber;
  late String name;
  late String lastName;
  late String mothersLastName;
  late String? photo;
  late String corporateEmail;

  EmployeeModel({
    this.id = 0,
    this.employeeNumber = "",
    this.name = "",
    this.lastName = "",
    this.mothersLastName = "",
    this.photo = "",
    this.corporateEmail = "",
});

  factory EmployeeModel.fromJson(Map<String, dynamic> map){
    return EmployeeModel(
      id: map['id'],
      employeeNumber: map['employeeNumber'],
      name: map['name'],
      lastName: map['lastName'],
      mothersLastName: map['mothersLastName'],
      photo: map['photo'],
      corporateEmail: map['corporateEmail'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employeeNumber'] = employeeNumber;
    data['name'] = name;
    data['lastName'] = lastName;
    data['mothersLastName'] = mothersLastName;
    data['photo'] = photo;
    data['corporateEmail'] = corporateEmail;
    return data;
  }
}