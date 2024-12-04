import 'package:flutter/material.dart';
import 'package:smart_cart_app/features/home/presentation/views/widgets/cart_list_view_item.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Cart",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontFamily: "Carmen"),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: ListView.builder(
                    itemBuilder: (context, index) => const CartListViewItem(),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10),
              )
            ],
          ),
        ),
      ),
    );
  }
}
