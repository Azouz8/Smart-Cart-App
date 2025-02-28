import 'package:flutter/material.dart';
import 'package:smart_cart_app/core/themes/light_theme/app_colors_light.dart';
import 'package:smart_cart_app/features/home/presentation/views/widgets/custom_home_app_bar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomHomeAppBar(title: "Profile"),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage("assets/images/ProfilePicture.png"),
                  // child: SvgPicture.asset(
                  //   "assets/images/ProfilePicture.svg",
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const ProfileInfoWidget(
              preIcon: Icons.person,
              label: "Name",
              value: "Ali Azouz",
            ),
            const MyDivider(),
            const ProfileInfoWidget(
              preIcon: Icons.email,
              label: "Email",
              value: "AliAzouz@gmail.com",
            ),
            const MyDivider(),
            const ProfileInfoWidget(
              preIcon: Icons.password,
              label: "Change Password",
              value: "*********",
            ),
            const MyDivider(),
            GestureDetector(
              onTap: () {},
              child: const ProfileInfoWidget(
                preIcon: Icons.card_travel,
                label: "Your Orders",
                value: "",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Divider(
          thickness: 0.5,
          endIndent: 20,
          indent: 20,
          color: Colors.grey.withAlpha(50),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({
    super.key,
    required this.preIcon,
    required this.label,
    required this.value,
  });

  final IconData preIcon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          preIcon,
          color: AppColorsLight.primaryColor,
          size: 26,
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontFamily: "Carmen", fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontFamily: "Carmen", color: Colors.grey),
        ),
        const SizedBox(
          width: 12,
        ),
        const Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
          size: 20,
        ),
      ],
    );
  }
}
