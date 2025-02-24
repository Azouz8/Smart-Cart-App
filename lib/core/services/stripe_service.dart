import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:smart_cart_app/core/networking/api/api_service.dart';
import 'package:smart_cart_app/features/checkout/data/models/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:smart_cart_app/features/checkout/data/models/init_payment_sheet_input_model/init_payment_sheet_input_model.dart';
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

  Future<EphemeralKeyModel> createEphemeralKey(String customerID) async {
    var response = await apiService.createEphemeralKey(customerId: customerID);
    var ephmeralKeyModel = EphemeralKeyModel.fromJson(response);
    return ephmeralKeyModel;
  }

  Future initPaymentSheet({
    required InitPaymentSheetInputModel initPaymentSheetInputModel,
  }) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret:
          initPaymentSheetInputModel.paymentIntentClientSecret,
      customerEphemeralKeySecret:
          initPaymentSheetInputModel.customerEphemeralKeySecret,
      customerId: initPaymentSheetInputModel.customerID,
      merchantDisplayName: "SSC",
    ));
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future retrievePaymentInfo(String clientSecret) async {
    var response = await Stripe.instance.retrievePaymentIntent(clientSecret);
    print("HEEEEEEEEERRRRRREEEEEEEEEEE");
    // print(response);
    var paymentMethodId = response.paymentMethodId;
    
  }

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    var ephemeralKeyModel =
        await createEphemeralKey(paymentIntentInputModel.customerId);
    var initPaymentSheetInputModel = InitPaymentSheetInputModel(
      paymentIntentClientSecret: paymentIntentModel.clientSecret!,
      customerEphemeralKeySecret: ephemeralKeyModel.secret!,
      customerID: paymentIntentInputModel.customerId,
    );
    await initPaymentSheet(
        initPaymentSheetInputModel: initPaymentSheetInputModel);
    await displayPaymentSheet();
    await retrievePaymentInfo(paymentIntentModel.clientSecret!);
  }
}
