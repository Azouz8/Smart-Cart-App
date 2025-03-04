import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cart_app/core/services/helper_functions.dart';
import 'package:smart_cart_app/features/rating/presentation/manager/rating_cubit.dart';

import '../../../../home/presentation/views/widgets/custom_home_app_bar.dart';
import 'user_orders_list_view_item.dart';

class UserOrdersViewBody extends StatelessWidget {
  const UserOrdersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RatingCubit, RatingState>(listener: (context, state) {
      if (state is RatingGetUserOrdersFailure) {
        showCustomSnackBar(
            context: context, message: state.errMessage, vPadding: 32);
      }
    }, builder: (context, state) {
      var cubit = RatingCubit.get(context);
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomHomeAppBar(title: "Your Orders"),
              if (state is RatingGetUserOrdersLoading)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.center,
                        heightFactor: MediaQuery.sizeOf(context).height * 0.02,
                        child: const CircularProgressIndicator()),
                  ],
                ),
              if (state is RatingGetUserOrdersSuccess ||
                  state is RatingPostUserRatingsSuccess)
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: cubit.orders.length,
                    itemBuilder: (context, index) => UserOrdersListViewItem(
                      orderModel: cubit.orders[index],
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 8),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
