import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_cart_app/core/services/helper_functions.dart';
import 'package:smart_cart_app/core/services/secure_storage.dart';
import 'package:smart_cart_app/features/authentication/presentation/manager/auth_cubit/auth_states.dart';
import '../../../../../core/routing/app_router.dart';
import '../../../../../core/themes/light_theme/app_colors_light.dart';
import '../../manager/auth_cubit/auth_cubit.dart';
import 'custom_text_form_field.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.cubit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthLoginSuccess) {
          showCustomSnackBar(context: context, message: "Welcome Back!");
          SecureStorage().writeData(
              key: SecureStorageKeys.token, value: state.loginModel.token!);
          GoRouter.of(context).push(AppRouter.categoriesView);
        } else if (state is AuthLoginFailure) {
          showCustomSnackBar(context: context, message: state.errMessage);
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.15,
                      ),
                      SvgPicture.asset(
                        "assets/images/loginIcon.svg",
                        height: 100,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        "Hello Again!",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff1A2530),
                            ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Welcome Back You've Been Missed!",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      CustomTextFormField(
                        controller: emailController,
                        label: "Email Address",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email Must Not Be Empty!";
                          }
                          return null;
                        },
                        prefixIcon: const Icon(Icons.email),
                        type: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextFormField(
                        controller: passwordController,
                        label: "Password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password!";
                          }
                          return null;
                        },
                        prefixIcon: const Icon(Icons.password),
                        type: TextInputType.text,
                        obsecureText: cubit.isPassword,
                        suffixIcon: IconButton(
                          icon: cubit.passwordIcon,
                          onPressed: () {
                            cubit.changePasswordVisibility();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              GoRouter.of(context)
                                  .push(AppRouter.passwordRecoveryView);
                            },
                            overlayColor: const WidgetStatePropertyAll(
                              AppColorsLight.scaffoldBackgroundColor,
                            ),
                            child: Text(
                              "Forgot Password?",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.loginUser(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all(
                                const Color(0xff5b9ee1)),
                          ),
                          child: state is AuthLoginLoading
                              ? const SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  "Login",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                      ),
                      InkWell(
                        onTap: () {
                          GoRouter.of(context).push(AppRouter.registerView);
                        },
                        overlayColor: const WidgetStatePropertyAll(
                            AppColorsLight.scaffoldBackgroundColor),
                        borderRadius: BorderRadius.circular(15),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 8,
                            right: 8,
                          ),
                          child: Text(
                            ' Sign Up For Free!',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
