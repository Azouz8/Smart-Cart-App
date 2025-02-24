import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cart_app/features/checkout/data/models/payment_intent_input_model/payment_intent_input_model.dart';
import 'package:smart_cart_app/features/checkout/data/models/payment_method_info/payment_method_info.dart';
import 'package:smart_cart_app/features/checkout/data/repos/checkout_repo.dart';
import 'checkout_states.dart';

class CheckoutCubit extends Cubit<CheckoutStates> {
  CheckoutCubit(this.checkoutRepo) : super(CheckoutInitial());
  static CheckoutCubit get(context) => BlocProvider.of(context);
  final CheckoutRepo checkoutRepo;
  PaymentMethodInfo paymentMethodInfo = PaymentMethodInfo();

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    emit(CheckoutLoading());
    var data = await checkoutRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);
    data.fold((failure) {
      emit(CheckoutFailure(failure));
    }, (response) {
       print("KKKKKKKKKKKKKKKKKKKKKKKKKKK");
      print(response);
      paymentMethodInfo = response;
      emit(CheckoutSuccess(response));
    });
  }

  // Future retrievePaymentInfo({required String clientSecret}) async {
  //   emit(CheckoutRetrievePaymentMethodLoading());
  //   var data =
  //       await checkoutRepo.retrievePaymentInfo(clientSecret: clientSecret);
  //   data.fold((failure) {
  //     emit(CheckoutRetrievePaymentMethodFailure(failure));
  //   }, (response) {
  //     print("KKKKKKKKKKKKKKKKKKKKKKKKKKK");
  //     print(response);
  //     paymentMethodInfo = response;
  //     emit(CheckoutRetrievePaymentMethodSuccess(response));
  //   });
  // }
}
