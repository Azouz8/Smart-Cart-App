import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_cart_app/features/home/data/models/recommendations_model/RecommendedItems.dart';

class OffersListViewItem extends StatelessWidget {
  const OffersListViewItem({
    super.key,
    required this.recommendedItem,
  });

  final RecommendedItems recommendedItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.15,
      child: Container(
        margin: const EdgeInsets.only(bottom: 0),
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 0.95,
                child: CachedNetworkImage(
                  imageUrl: recommendedItem.image ?? "",
                  errorWidget: (context, url, error) => SvgPicture.asset(
                    "assets/images/ImagePlaceholder.svg",
                    width: MediaQuery.sizeOf(context).width * 0.22,
                    fit: BoxFit.scaleDown,
                  ),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            SizedBox(
              width: 18.w,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recommendedItem.title!,
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
                  Row(
                    children: [
                      Text(
                        "\$ ${recommendedItem.price}",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontFamily: "Carmen",
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                      const Spacer(),
                      RatingBar.builder(
                        itemSize: 10,
                        ignoreGestures: true,
                        initialRating: recommendedItem.rating!,
                        direction: Axis.horizontal,
                        glow: false,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
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
                        "\$ total",
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
