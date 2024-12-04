import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartListViewItem extends StatelessWidget {
  const CartListViewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.19,
      child: Card(
        // clipBehavior: Clip.antiAlias,
        borderOnForeground: false,
        elevation: 0.2,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                      "Lorem Ipsum is simply dummy text of the printing and typesetting",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontFamily: "Carmen", fontWeight: FontWeight.bold),
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
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontFamily: "Carmen",
                                  fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Spacer(),
                        Text(
                          "3",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
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
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontFamily: "Carmen",
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          "\$750",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
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
      ),
    );
  }
}
