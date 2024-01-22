
class ProductCategoryModel{
  late int id;
  late String name;

  ProductCategoryModel({
    this.id = 0,
    this.name = ""
});

  factory ProductCategoryModel.fromJson(Map<String, dynamic> map){
    return ProductCategoryModel(
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