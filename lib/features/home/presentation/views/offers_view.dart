import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cart_app/features/home/presentation/views/widgets/offers_list_view_item.dart';
import '../../../../core/services/cache_helper.dart';
import '../../../../core/services/helper_functions.dart';
import '../manager/recommendation_cubit/recommendation_cubit.dart';
import 'widgets/custom_home_app_bar.dart';

class OffersView extends StatelessWidget {
  OffersView({super.key});
  final String? userRecommendationId = CacheHelper.getString(key: CacheHelperKeys.userRecommendationID);
  @override
  Widget build(BuildContext context) {
    var cubit = RecommendationCubit.get(context);
    cubit.getRecommendations(userRecommendationId ?? "4");
    return BlocConsumer<RecommendationCubit, RecommendationState>(
      listener: (context, state) {
        if (state is RecommendedProductsFailure) {
          showCustomSnackBar(
              context: context, message: state.errMessage, vPadding: 16);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: state is RecommendedProductsSuccess
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomHomeAppBar(
                          title: "Offers for You",
                        ),
                        ListView.separated(
                          reverse: true,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, index) => ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: OffersListViewItem(
                              recommendedItem: state.recommendations[index],
                            ),
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.recommendations.length,
                        )
                      ],
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
