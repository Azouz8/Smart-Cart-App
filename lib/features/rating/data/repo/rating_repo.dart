import 'package:either_dart/either.dart';
import '../models/order_model/order_model.dart';
import '../models/rating_model/rating_model.dart';

abstract class RatingRepo {
  Future<Either<String, List<OrderModel>>> getUserOrders();
  Future<Either<String, Map<String, dynamic>>> postUserRatings(
      {required List<RatingModel> ratings, required String orderID});
}
