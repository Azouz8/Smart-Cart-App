import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_cart_app/features/checkout/data/models/payment_intent_input_model/payment_intent_input_model.dart';
import 'package:smart_cart_app/features/checkout/data/models/payment_method_info/payment_method_info.dart';
import 'package:smart_cart_app/features/checkout/data/repos/checkout_repo.dart';
import 'checkout_states.dart';

class CheckoutCubit extends Cubit<CheckoutStates> {
  CheckoutCubit(this.checkoutRepo) : super(CheckoutInitial());
  static CheckoutCubit get(context) => BlocProvider.of(context);
  final CheckoutRepo checkoutRepo;
  PaymentMethodInfo paymentMethodInfo = PaymentMethodInfo();
  late String currentDate, currentTime;
  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    emit(CheckoutLoading());
    var data = await checkoutRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);
    data.fold((failure) {
      emit(CheckoutFailure(failure));
    }, (response) {
      paymentMethodInfo = response;
      getCurrentTimeDate();
      emit(CheckoutSuccess(response));
    });
  }

  getCurrentTimeDate() {
    DateTime now = DateTime.now();
    currentDate = DateFormat('MM/dd/yyyy').format(now);
    currentTime = DateFormat('hh:mm a').format(now);
  }
}
