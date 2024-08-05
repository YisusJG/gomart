class CyclicalInventoryModel {
  int id;
  int categoryId;
  String nameCyclicalInventory;
  String inventoryTypeName;
  String category;
  String frequency;
  String subFrequency;
  int frequencyDays;
  String specificTime;

  CyclicalInventoryModel({
    this.id = 0,
    this.categoryId = 0,
    this.nameCyclicalInventory = '',
    this.inventoryTypeName = '',
    this.category = '',
    this.frequency = '',
    this.subFrequency = '',
    this.frequencyDays = 0,
    this.specificTime = '',
  });

  factory CyclicalInventoryModel.fromJson(Map<String, dynamic> map) {
    return CyclicalInventoryModel(
      id: map['id'] as int,
      categoryId: map['categoryId'] as int,
      nameCyclicalInventory: map['nameCyclicalInventory'] as String,
      inventoryTypeName: map['inventoryTypeName'] as String,
      category: map['category'] as String,
      frequency: map['frequency'] as String,
      subFrequency: map['subFrequency'] as String,
      frequencyDays: map['frequencyDays'] as int,
      specificTime: map['specificTime'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['categoryId'] = categoryId;
    data['nameCyclicalInventory'] = nameCyclicalInventory;
    data['inventoryTypeName'] = inventoryTypeName;
    data['category'] = category;
    data['frequency'] = frequency;
    data['subFrequency'] = subFrequency;
    data['frequencyDays'] = frequencyDays;
    data['specificTime'] = specificTime;
    return data;
  }

}