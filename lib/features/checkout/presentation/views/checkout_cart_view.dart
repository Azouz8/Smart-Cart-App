import 'package:flutter/material.dart';

class CheckoutCartView extends StatelessWidget {
  const CheckoutCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text("Checkout View"),
      ),
    );
  }
}
