import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cart_app/features/rating/data/models/order_model/order_model.dart';
import 'package:smart_cart_app/features/rating/data/repo/rating_repo.dart';

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
}
