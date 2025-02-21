import 'package:either_dart/either.dart';

import '../models/payment_intent_input_model/payment_intent_input_model.dart';

abstract class CheckoutRepo {
  Future<Either<String, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel});
}
