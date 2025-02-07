import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cart_app/core/services/service_locator.dart';
import 'package:smart_cart_app/features/authentication/data/repos/auth_repo_impl.dart';
import 'package:smart_cart_app/features/authentication/presentation/manager/auth_cubit/auth_cubit.dart';
import 'widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AuthCubit(getIt.get<AuthRepoImpl>()),
        child: Scaffold(body: RegisterViewBody()));
  }
}
