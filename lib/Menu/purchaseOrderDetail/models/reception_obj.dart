class ReceptionObj{
  final int receptionId;

  ReceptionObj({
    this.receptionId = 0,
  });

  factory ReceptionObj.fromJson(Map<String, dynamic> map) {
    return ReceptionObj(
      receptionId: map["id"]
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['receptionId'] = receptionId;
    return data;
  }

}