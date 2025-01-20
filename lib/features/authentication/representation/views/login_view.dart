import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_cart_app/core/routing/app_router.dart';
import 'package:smart_cart_app/core/themes/light_theme/app_colors_light.dart';
import 'package:smart_cart_app/features/authentication/representation/manager/auth_cubit/auth_cubit.dart';
import 'package:smart_cart_app/features/authentication/representation/manager/auth_cubit/auth_states.dart';
import 'package:smart_cart_app/features/authentication/representation/views/widgets/customTextFormField.dart';

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
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.sizeOf(context).height,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Form(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
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
                                icon: cubit.suffixIcon,
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
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {
                                  // if (formKey.currentState!.validate()) {
                                  //   // Login Code
                                  // }
                                  GoRouter.of(context).push(AppRouter.homeView);
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
                                child: Text(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
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
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
