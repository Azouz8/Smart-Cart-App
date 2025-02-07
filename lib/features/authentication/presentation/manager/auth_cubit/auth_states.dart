abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class ChangePasswordVisibility extends AuthStates {}

class ChangeGender extends AuthStates {}

class AuthSignUpLoading extends AuthStates {}

class AuthSignUpFailure extends AuthStates {
  String errMessage;
  AuthSignUpFailure(this.errMessage);
}

class AuthSignUpSuccess extends AuthStates {}
