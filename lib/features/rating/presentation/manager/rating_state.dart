part of 'rating_cubit.dart';

abstract class RatingState {}

class RatingInitial extends RatingState {}
class RatingGetUserOrdersLoading extends RatingState {}
class RatingGetUserOrdersFailure extends RatingState {
  String errMessage;
  RatingGetUserOrdersFailure(this.errMessage);
}
class RatingGetUserOrdersSuccess extends RatingState {
  List<OrderModel> orders;
  RatingGetUserOrdersSuccess(this.orders);
}
