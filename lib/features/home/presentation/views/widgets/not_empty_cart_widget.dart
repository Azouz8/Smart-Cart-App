import 'package:flutter/material.dart';
import 'package:smart_cart_app/features/home/data/models/cart_product_model/cart_product_model.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:smart_cart_app/features/home/presentation/views/widgets/connected_cart_custom_appbar.dart';
import 'cart_list_view_item.dart';
import 'checkout_button.dart';

class NotEmptyCartWidget extends StatelessWidget {
  const NotEmptyCartWidget({
    super.key,
    required this.products,
  });

  final List<CartProductModel> products;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConnectedCartCustomAppBar(),
            ListView.builder(
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Dismissible(
                  key: const Key(""),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    HomeCubit.get(context).deleteProductFromCart(
                      cartID: HomeCubit.get(context).cartId,
                      productID: products[index].productID!.id!,
                    );
                  },
                  background: Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: CartListViewItem(
                    cartProductModel: products[index],
                  ),
                ),
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
            ),
            const CheckoutButton(),
          ],
        ),
      ),
    );
  }
}
