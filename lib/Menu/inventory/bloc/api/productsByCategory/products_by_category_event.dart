
abstract class ProductsByCategoryEvent{}

class LoadProductsByCategoryEvent extends ProductsByCategoryEvent{
  final int categoryId;

  LoadProductsByCategoryEvent({this.categoryId = 0});

}