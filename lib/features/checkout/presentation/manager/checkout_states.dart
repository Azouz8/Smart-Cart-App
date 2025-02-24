
abstract class CheckoutStates {}

class CheckoutInitial extends CheckoutStates {}

class CheckoutLoading extends CheckoutStates {}

class CheckoutFailure extends CheckoutStates {
  String errMessage;
  CheckoutFailure(this.errMessage);
}

class CheckoutSuccess extends CheckoutStates {
  // SuccessPaymentModel successPaymentModel;
  // CheckoutSuccess(this.successPaymentModel);
}
