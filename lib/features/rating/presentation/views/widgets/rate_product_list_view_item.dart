import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'rating_bar_widget.dart';

class RateProductListViewItem extends StatelessWidget {
  const RateProductListViewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.19,
      child: Card(
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
              SizedBox(
                width: 18.w,
              ),
              Expanded(
                child: Column(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lorem Ipsum is simply dummy text",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontFamily: "Carmen", fontWeight: FontWeight.bold),
                    ),
                    const RatingBarWidget()
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
