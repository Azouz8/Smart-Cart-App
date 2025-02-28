import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_states.dart';
import 'package:smart_cart_app/features/home/presentation/views/widgets/offers_list_view_item.dart';

import '../../../../core/services/helper_functions.dart';
import 'widgets/custom_home_app_bar.dart';

class OffersView extends StatelessWidget {
  const OffersView({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    cubit.getRecommendations("4");
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomeGetRecommendedProductsFailure) {
          showCustomSnackBar(
              context: context, message: state.errMessage, vPadding: 16);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomHomeAppBar(
                    title: "Offers for You",
                  ),
                  state is HomeGetRecommendedProductsSuccess
                      ? ListView.separated(
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
                      : const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
