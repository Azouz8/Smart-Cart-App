import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cart_app/features/rating/data/models/order_model/order_model.dart';
import 'package:smart_cart_app/features/rating/data/repo/rating_repo.dart';

import '../../data/models/rating_model/rating_model.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  RatingCubit(this.ratingRepo) : super(RatingInitial());

  static RatingCubit get(context) => BlocProvider.of(context);
  final RatingRepo ratingRepo;
  List<OrderModel> orders = [];

  Future<void> gerUserOrders() async {
    emit(RatingGetUserOrdersLoading());
    var result = await ratingRepo.getUserOrders();
    result.fold((failure) {
      emit(RatingGetUserOrdersFailure(failure));
    }, (result) {
      orders = result;
      emit(RatingGetUserOrdersSuccess(result));
    });
  }

  Future<void> postUserRatings({required List<RatingModel> ratings}) async {
    emit(RatingPostUserRatingsLoading());
    var result = await ratingRepo.postUserRatings(ratings: ratings);
    result.fold((failure) {
      emit(RatingPostUserRatingsFailure(failure));
    }, (result) {
      emit(RatingPostUserRatingsSuccess());
    });
  }
}
