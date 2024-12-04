import 'package:flutter/material.dart';

class CartListViewItem extends StatelessWidget {
  const CartListViewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.16,
      child: Card(
        borderOnForeground: false,
        elevation: 0.2,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Image.asset(
                "assets/images/Image_placeholder.png",
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 18,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lorem",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(
                          fontFamily: "Carmen",
                        ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "\$250.00",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(
                            fontFamily: "Carmen", color: Colors.grey),
                  ),
                  const Spacer(),
                  Text(
                    "Total",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(
                            fontFamily: "Carmen",
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Quantity",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(
                          fontFamily: "Carmen",
                        ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "3",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(
                            fontFamily: "Carmen", color: Colors.grey),
                  ),
                  const Spacer(),
                  Text(
                    "\$750",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(
                            fontFamily: "Carmen",
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
