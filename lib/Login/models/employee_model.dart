class EmployeeModel{
  late String employeeNumber;
  late String name;
  late String lastName;
  late String mothersLastName;
  late String? photo;
  late String corporateEmail;

  EmployeeModel({
    this.employeeNumber = "",
    this.name = "",
    this.lastName = "",
    this.mothersLastName = "",
    this.photo = "",
    this.corporateEmail = "",
});

  factory EmployeeModel.fromJson(Map<String, dynamic> map){
    return EmployeeModel(
      employeeNumber: map['employeeNumber'],
      name: map['name'],
      lastName: map['lastName'],
      mothersLastName: map['mothersLastName'],
      photo: map['photo'],
      corporateEmail: map['corporateEmail']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employeeNumber'] = employeeNumber;
    data['name'] = name;
    data['lastName'] = lastName;
    data['mothersLastName'] = mothersLastName;
    data['photo'] = photo;
    data['corporateEmail'] = corporateEmail;
    return data;
  }
}