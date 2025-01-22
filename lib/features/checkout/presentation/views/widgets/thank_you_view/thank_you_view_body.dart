import 'package:flutter/material.dart';
import 'thank_you_check_mark.dart';
import 'thank_you_container.dart';
import 'thank_you_dashed_line.dart';
import 'thank_you_half_circle.dart';

class ThankYouViewBody extends StatelessWidget {
  const ThankYouViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 24, left: 24, right: 24, top: 72),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ThankYouContainer(),
          ThankYouDashedLine(),
          ThankYouHalfCircle(left: -20),
          ThankYouHalfCircle(right: -20),
          ThankYouCheckMark(),
        ],
      ),
    );
  }
}
