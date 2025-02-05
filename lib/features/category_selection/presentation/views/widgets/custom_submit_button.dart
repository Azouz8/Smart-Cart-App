import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomSubmitButton extends StatelessWidget {
  const CustomSubmitButton({
    super.key,
    required this.title,
    required this.route,
  });
  final String title, route;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        GoRouter.of(context).push(route);
      },
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(const Color(0xff5b9ee1)),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontFamily: "Carmen",
            ),
      ),
      // child: const SizedBox(
      //   height: 15,
      //   width: 15,
      //   child: CircularProgressIndicator(
      //     color: Colors.white,
      //     strokeWidth: 2,
      //   ),
      // ),
    );
  }
}
