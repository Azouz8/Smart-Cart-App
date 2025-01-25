import 'package:flutter/material.dart';
import 'package:smart_cart_app/features/rating/presentation/views/widgets/rate_product_list_view_item.dart';
import '../../../../home/presentation/views/widgets/custom_home_app_bar.dart';

class RateProductsViewBody extends StatelessWidget {
  const RateProductsViewBody({super.key});

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
                title: "Rate Products",
              ),
              ListView.builder(
                itemBuilder: (context, index) =>
                    const RateProductListViewItem(),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // if (formKey.currentState!.validate()) {
                    //   // Login Code
                    // }
                  },
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    backgroundColor:
                        WidgetStateProperty.all(const Color(0xff5b9ee1)),
                  ),
                  child: Text(
                    "Submit Ratings",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
