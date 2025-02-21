import 'package:either_dart/either.dart';
import 'package:smart_cart_app/core/networking/errors/exceptions.dart';
import 'package:smart_cart_app/core/services/stripe_service.dart';
import 'package:smart_cart_app/features/checkout/data/models/payment_intent_input_model/payment_intent_input_model.dart';
import 'checkout_repo.dart';

class CheckoutRepoImpl extends CheckoutRepo {
  StripeService stripeService;
  CheckoutRepoImpl(this.stripeService);
  @override
  Future<Either<String, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await stripeService.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errMessage);
    }
  }
}
