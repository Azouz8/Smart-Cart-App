import 'package:flutter/material.dart';
import 'package:smart_cart_app/features/rating/data/models/order_model/order_model.dart';
import 'package:smart_cart_app/features/rating/presentation/views/widgets/rate_products_view_body.dart';

class RateProductsView extends StatelessWidget {
  const RateProductsView({super.key, required this.orderModel});
  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RateProductsViewBody(
        orderModel: orderModel,
      ),
    );
  }
}
