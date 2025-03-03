import 'package:flutter/material.dart';

import 'custom_home_app_bar.dart';
import 'user_orders_list_view_item.dart';

class UserOrdersViewBody extends StatelessWidget {
  const UserOrdersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomHomeAppBar(title: "Your Orders"),
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                itemBuilder: (context, index) => const UserOrdersListViewItem(),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
