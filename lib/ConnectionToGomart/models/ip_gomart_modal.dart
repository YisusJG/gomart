class IpGomartModal{
  late int id;
  late String ip;

  IpGomartModal({
    this.id = 0,
    this.ip = ""
  });

  factory IpGomartModal.fromJson(Map<String, dynamic> map) {
    return IpGomartModal(
      id: map["id"],
      ip: map['ip']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ip'] = ip;
    return data;
  }
}