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
    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }
}
