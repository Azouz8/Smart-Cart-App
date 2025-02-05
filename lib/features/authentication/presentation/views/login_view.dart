import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cart_app/features/authentication/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:smart_cart_app/features/authentication/presentation/manager/auth_cubit/auth_states.dart';

import 'widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var cubit = AuthCubit.get(context);
          return Scaffold(
            body: LoginViewBody(
                formKey: formKey,
                emailController: emailController,
                passwordController: passwordController,
                cubit: cubit),
          );
        },
      ),
    );
  }
}
