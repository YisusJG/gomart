
abstract class ProductsByCategoryEvent{}

class LoadProductsByCategoryEvent extends ProductsByCategoryEvent{
  final int categoryId;

  LoadProductsByCategoryEvent({this.categoryId = 0});

  /*@override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is LoadProductsByCategoryEvent &&
              runtimeType == other.runtimeType &&
              categoryId == other.categoryId;

  @override
  int get hashCode => categoryId.hashCode;*/
}