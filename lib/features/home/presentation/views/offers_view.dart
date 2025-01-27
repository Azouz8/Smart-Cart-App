import 'package:flutter/material.dart';
import 'widgets/custom_home_app_bar.dart';
import 'widgets/offers_list_view_item.dart';

class OffersView extends StatelessWidget {
  const OffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomHomeAppBar(
                title: "Offers for You",
              ),
              ListView.builder(
                itemBuilder: (context, index) => const OffersListViewItem(),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
