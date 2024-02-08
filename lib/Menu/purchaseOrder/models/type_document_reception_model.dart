class TypeDocumentReceptionModel {
  final int id;
  final String name;

  TypeDocumentReceptionModel({
    this.id = 0,
    this.name = ''
  });

  factory TypeDocumentReceptionModel.fromJson(Map<String, dynamic> map) {
    return TypeDocumentReceptionModel(
      id: map['id'],
      name:  map['name']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}