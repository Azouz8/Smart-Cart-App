import 'package:either_dart/either.dart';
import 'package:smart_cart_app/features/rating/data/models/order_model/order_model.dart';

abstract class RatingRepo {
  Future<Either<String, List<OrderModel>>> getUserOrders();
}
