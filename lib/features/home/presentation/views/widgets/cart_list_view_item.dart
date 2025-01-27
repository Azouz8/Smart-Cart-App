import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_cart_app/features/home/presentation/views/cart_view.dart';

class CartListViewItem extends StatelessWidget {
  const CartListViewItem({
    super.key,
    required this.cartItemModel,
  });
  final CartItemModel cartItemModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.2,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/images/ImagePlaceholder.svg",
              width: MediaQuery.sizeOf(context).width * 0.22,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 18,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItemModel.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "\$250.00",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontFamily: "Carmen",
                        color: Colors.grey,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Quantity",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontFamily: "Carmen", fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Spacer(),
                      Text(
                        "3",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontFamily: "Carmen",
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        "Total",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontFamily: "Carmen",
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        "\$750",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontFamily: "Carmen",
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
