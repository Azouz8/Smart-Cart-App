import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cart_app/features/checkout/data/models/payment_intent_input_model/payment_intent_input_model.dart';
import 'package:smart_cart_app/features/checkout/data/repos/checkout_repo.dart';
import 'checkout_states.dart';

class CheckoutCubit extends Cubit<CheckoutStates> {
  CheckoutCubit(this.checkoutRepo) : super(CheckoutInitial());
  final CheckoutRepo checkoutRepo;

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    emit(CheckoutLoading());
    var data = await checkoutRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);
    data.fold((failure) {
      emit(CheckoutFailure(failure));
    }, (response) {
      emit(CheckoutSuccess());
    });
  }
}
