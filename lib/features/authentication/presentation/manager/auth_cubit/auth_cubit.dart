import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  Icon passwordIcon = const Icon(Icons.visibility_outlined);
  bool isPassword = true;
  Icon confirmedPasswordIcon = const Icon(Icons.visibility_outlined);
  bool isConfirmedPassword = true;
  bool isMaleSelected = true;
  String gender = "Male";
  void changePasswordVisibility() {
    isPassword = !isPassword;
    passwordIcon = isPassword
        ? const Icon(Icons.visibility_outlined)
        : const Icon(Icons.visibility_off_outlined);
    emit(ChangePasswordVisibility());
  }

  void changeConfirmedPasswordVisibility() {
    isConfirmedPassword = !isConfirmedPassword;
    confirmedPasswordIcon = isConfirmedPassword
        ? const Icon(Icons.visibility_outlined)
        : const Icon(Icons.visibility_off_outlined);
    emit(ChangePasswordVisibility());
  }

  void changeGender(bool isMale) {
    isMaleSelected = isMale;
    gender = isMale ? "Male" : "Female";
    print(isMaleSelected);
    emit(ChangeGender());
  }
}
