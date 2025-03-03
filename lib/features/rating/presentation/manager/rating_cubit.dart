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
  List<Map<String, dynamic>> ratingList = [];

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

  Future<void> postUserRatings(
      {required List<RatingModel> ratings, required String orderID}) async {
    emit(RatingPostUserRatingsLoading());
    var result =
        await ratingRepo.postUserRatings(ratings: ratings, orderID: orderID);
    result.fold((failure) {
      emit(RatingPostUserRatingsFailure(failure));
    }, (result) {
      emit(RatingPostUserRatingsSuccess());
    });
  }

  void updateRatingList(String productID, String rating) {
    int index = ratingList.indexWhere((map) => map['productID'] == productID);

    if (index != -1) {
      ratingList[index]['userRating'] = rating;
    } else {
      ratingList.add({
        'productID': productID,
        'userRating': rating,
      });
    }
  }
}
