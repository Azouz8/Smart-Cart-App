import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(
                        flex: 2,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Create Account",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Carmen",
                                ),
                              ),
                              Text(
                                "Let’s Create Account Together",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontFamily: "Carmen",
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 50,
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
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              print(emailController.text);
                              print(passwordController.text);
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
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "Carmen",
                            ),
                          ),
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontFamily: "Carmen",
                              color: Colors.grey,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(' Sign In',
                                style: TextStyle(
                                    fontFamily: "Carmen",
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      )
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
