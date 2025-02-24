import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_cart_app/features/checkout/presentation/manager/checkout_cubit.dart';
import 'package:smart_cart_app/features/checkout/presentation/views/widgets/checkout_view/total_price_widget.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'thank_you_payment_method_info.dart';

class ThankYouContainer extends StatelessWidget {
  const ThankYouContainer({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    var totalPrice = HomeCubit.get(context).totalPrice;
    var currentDate = CheckoutCubit.get(context).currentDate;
    var currentTime = CheckoutCubit.get(context).currentTime;
    return Container(
      height: 550.h,
      padding: const EdgeInsets.only(right: 28, left: 28, top: 44, bottom: 8),
      decoration: ShapeDecoration(
        color: const Color(0xffededed),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Column(
        spacing: 12,
        children: [
          Text(
            "Thank You!",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            "Your Transaction was Successfull",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Text(
                "Date",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const Spacer(),
              Text(
                currentDate,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Time",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const Spacer(),
              Text(
                currentTime,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const Divider(
            thickness: 0.5,
            color: Colors.grey,
            height: 30,
          ),
          TotalPriceWidget(price: "$totalPrice.00"),
          SizedBox(
            height: 10.h,
          ),
          const ThankYouPaymentMethodInfo(),
          SizedBox(
            height: 80.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset("assets/images/barcode.svg"),
              Container(
                height: 60.h,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1.5, color: Colors.green),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: const Color(0xffededed),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
                  child: Center(
                    child: Text(
                      "PAID",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.green),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
