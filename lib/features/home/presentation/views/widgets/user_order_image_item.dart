import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserOrderImageItem extends StatelessWidget {
  const UserOrderImageItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: AspectRatio(
        aspectRatio: 0.95,
        child: CachedNetworkImage(
          imageUrl: "",
          errorWidget: (context, url, error) => SvgPicture.asset(
            "assets/images/ImagePlaceholder.svg",
            width: MediaQuery.sizeOf(context).width * 0.22,
            fit: BoxFit.scaleDown,
          ),
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}