class ErrorMessaje{
  late String messaje;


  ErrorMessaje({
    this.messaje = "",
  });

  factory ErrorMessaje.fromJson(Map<String, dynamic> map){
    return ErrorMessaje(
      messaje: map['messaje'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['messaje'] = messaje;
    return data;
  }
}