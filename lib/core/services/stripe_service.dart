import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:smart_cart_app/core/networking/api/api_service.dart';
import 'package:smart_cart_app/features/checkout/data/models/payment_intent_input_model/payment_intent_input_model.dart';
import 'package:smart_cart_app/features/checkout/data/models/payment_intent_model/payment_intent_model.dart';

class StripeService {
  ApiService apiService;
  StripeService(this.apiService);
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    var response = await apiService.createPaymentIntent(
        paymentIntentInputModel: paymentIntentInputModel);
    var paymentIntentModel = PaymentIntentModel.fromJson(response);
    return paymentIntentModel;
  }

  Future initPaymentSheet({required String paymentIntentClientSecret}) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: paymentIntentClientSecret,
      merchantDisplayName: "SSC",
    ));
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment({required paymentIntentInputModel}) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    await initPaymentSheet(
        paymentIntentClientSecret: paymentIntentModel.clientSecret!);
    await displayPaymentSheet();
  }
}
