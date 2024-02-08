
class ProductSubCategoryModel{
  late int id;
  late String name;

  ProductSubCategoryModel({
    this.id = 0,
    this.name = ""
  });

  factory ProductSubCategoryModel.fromJson(Map<String, dynamic> map){
    return ProductSubCategoryModel(
        id: map['id'],
        name: map['name']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

}