import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OffersListViewItem extends StatelessWidget {
  const OffersListViewItem({
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
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          "Price",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.green),
                        ),
                        const Spacer(),
                        Text(
                          "\$750",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.green),
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
