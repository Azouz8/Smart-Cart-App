import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_cart_app/core/routing/app_router.dart';
import 'custom_credit_card.dart';
import 'payment_method_list_view.dart';

class PaymentDetailViewBody extends StatefulWidget {
  const PaymentDetailViewBody({super.key});

  @override
  State<PaymentDetailViewBody> createState() => _PaymentDetailViewBodyState();
}

class _PaymentDetailViewBodyState extends State<PaymentDetailViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: PaymentMethodListView()),
          SliverToBoxAdapter(
            child: CustomCreditCard(
              formKey: formKey,
              autovalidateMode: autovalidateMode,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: ElevatedButton(
                  onPressed: () {
                    // if (formKey.currentState!.validate()) {
                    //   formKey.currentState!.save();
                    // } else {
                    //   autovalidateMode = AutovalidateMode.always;
                    //   setState(() {});
                    // }
                    GoRouter.of(context).push(AppRouter.thankYouView);
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
                    "Pay",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontFamily: "Carmen",
                        ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
