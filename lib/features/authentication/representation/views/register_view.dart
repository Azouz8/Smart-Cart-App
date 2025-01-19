import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_cart_app/core/themes/light_theme/app_colors_light.dart';
import 'package:smart_cart_app/features/authentication/representation/manager/auth_cubit/auth_cubit.dart';
import 'package:smart_cart_app/features/authentication/representation/manager/auth_cubit/auth_states.dart';
import 'package:smart_cart_app/features/authentication/representation/views/widgets/customTextFormField.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final emailController = TextEditingController();
  final nameController = TextEditingController();
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
            // appBar: AppBar(scrolledUnderElevation: 0),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.sizeOf(context).height),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.15,
                                    ),
                                    SvgPicture.asset(
                                      "assets/images/registerIcon.svg",
                                      height: 100,
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                      "Create Account",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff1A2530),
                                            fontFamily: "Carmen",
                                          ),
                                    ),
                                    Text(
                                      "Let’s Create Account Together",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                            fontFamily: "Carmen",
                                          ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            CustomTextFormField(
                              controller: nameController,
                              label: "Name",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Name Must Not Be Empty!";
                                }
                                return null;
                              },
                              prefixIcon: const Icon(Icons.person),
                              type: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 16,
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
                              height: 16,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    // Registeration Code
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
                                child: Text("Register",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          fontFamily: "Carmen",
                                        )),
                              ),
                            ),
                            // SizedBox(
                            //   height: MediaQuery.sizeOf(context).height * 0.13,
                            // ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                  fontFamily: "Carmen",
                                ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
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
                                ' Sign In',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Carmen",
                                    ),
                              ),
                            ),
                          ),
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
