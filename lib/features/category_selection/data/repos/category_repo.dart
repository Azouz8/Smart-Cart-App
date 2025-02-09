import 'package:either_dart/either.dart';
import 'package:smart_cart_app/features/category_selection/data/models/category.dart';

abstract class CategoryRepo {
  Future<Either<String, List<Categories>>> getCategories();
}
