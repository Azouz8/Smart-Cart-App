import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_cart_app/core/routing/app_router.dart';
import 'package:smart_cart_app/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'widgets/profile_info_widget.dart';

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
              height: 20,
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
            InkWell(
              onTap: () {
                GoRouter.of(context).push(AppRouter.userOrdersView);
              },
              overlayColor: WidgetStateColor.transparent,
              borderRadius: BorderRadius.circular(16),
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
    return Divider(
      thickness: 0.5,
      endIndent: 20,
      indent: 20,
      color: Colors.grey.withAlpha(50),
    );
  }
}
