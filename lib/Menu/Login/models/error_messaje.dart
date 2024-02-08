class ErrorMessaje{
  late int typeMessage;
  late String message;


  ErrorMessaje({
    this.typeMessage = 0,
    this.message = "",
  });

  factory ErrorMessaje.fromJson(Map<String, dynamic> map){
    return ErrorMessaje(
      typeMessage: map['typeMessage'],
      message: map['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeMessage'] = typeMessage;
    data['message'] = message;
    return data;
  }
}