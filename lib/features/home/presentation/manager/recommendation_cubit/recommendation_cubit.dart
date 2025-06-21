import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cart_app/core/services/cache_helper.dart';
import '../../../data/models/recommendations_model/RecommendedItems.dart';
import '../../../data/repos/home_repo.dart';
part 'recommendation_state.dart';

class RecommendationCubit extends Cubit<RecommendationState> {
  RecommendationCubit(this.homeRepo) : super(RecommendationInitial());

  static RecommendationCubit get(context) => BlocProvider.of(context);
  HomeRepo homeRepo;
  List<RecommendedItems> recommendedProducts = [];
  String userRecommendationId =
      CacheHelper.getString(key: CacheHelperKeys.userRecommendationID)!;

  Future<void> getRecommendations() async {
    emit(RecommendedProductsLoading());
    var result =
        await homeRepo.getRecommendations(userID: userRecommendationId);
    result.fold((failure) {
      emit(RecommendedProductsFailure(failure));
    }, (products) {
      recommendedProducts = products;
      emit(RecommendedProductsSuccess(products));
    });
  }
}
