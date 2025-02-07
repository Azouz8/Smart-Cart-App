import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_cart_app/core/routing/app_router.dart';
import 'package:smart_cart_app/core/themes/light_theme/app_colors_light.dart';
import 'package:smart_cart_app/features/authentication/presentation/manager/auth_cubit/auth_states.dart';
import 'package:smart_cart_app/features/authentication/presentation/views/widgets/custom_text_form_field.dart';
import '../../manager/auth_cubit/auth_cubit.dart';

class RegisterViewBody extends StatelessWidget {
  RegisterViewBody({super.key});

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final birthDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<MultiSelectCard> list = [
    MultiSelectCard(value: 'Male', label: 'Male'),
    MultiSelectCard(value: 'Female', label: 'Female')
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthStates>(
      builder: (BuildContext context, state) {
        var cubit = AuthCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Form(
                  key: formKey,
                  child: Column(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * 0.1,
                              ),
                              SvgPicture.asset(
                                "assets/images/registerIcon.svg",
                                height: 80.h,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Create Account",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff1A2530),
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
                                    ),
                              ),
                            ],
                          )
                        ],
                      ),
                      CustomTextFormField(
                        controller: nameController,
                        label: "Name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This Field is Required!";
                          }
                          return null;
                        },
                        prefixIcon: const Icon(Icons.person),
                        type: TextInputType.text,
                      ),
                      CustomTextFormField(
                        controller: emailController,
                        label: "Email Address",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Your Email!";
                          } else if (!EmailValidator.validate(value)) {
                            return "Please Enter a valid Email!";
                          }
                          return null;
                        },
                        prefixIcon: const Icon(Icons.email),
                        type: TextInputType.emailAddress,
                      ),
                      CustomTextFormField(
                        controller: passwordController,
                        label: "Password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This Field is Required!";
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
                      CustomTextFormField(
                        controller: confirmPasswordController,
                        label: "Confirrm Password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password!";
                          } else if (value != passwordController.text) {
                            return "Passwords Does not match";
                          }
                          return null;
                        },
                        prefixIcon: const Icon(Icons.password),
                        type: TextInputType.text,
                        obsecureText: cubit.isConfirmedPassword,
                        suffixIcon: IconButton(
                          icon: cubit.confirmedPasswordIcon,
                          onPressed: () {
                            cubit.changeConfirmedPasswordVisibility();
                          },
                        ),
                      ),
                      Row(
                        spacing: 16,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                cubit.changeGender(true);
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: AnimatedContainer(
                                padding: const EdgeInsets.all(16),
                                decoration: ShapeDecoration(
                                  color: cubit.isMaleSelected
                                      ? AppColorsLight.primaryColor
                                      : Colors.grey.withAlpha(25),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                duration: const Duration(milliseconds: 400),
                                child: Text(
                                  "Male",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: cubit.isMaleSelected
                                            ? Colors.white
                                            : AppColorsLight.secondaryColor,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                cubit.changeGender(false);
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: AnimatedContainer(
                                padding: const EdgeInsets.all(16),
                                decoration: ShapeDecoration(
                                  color: cubit.isMaleSelected
                                      ? Colors.grey.withAlpha(25)
                                      : AppColorsLight.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                duration: const Duration(milliseconds: 400),
                                child: Text(
                                  "Female",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: cubit.isMaleSelected
                                            ? AppColorsLight.secondaryColor
                                            : Colors.white,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        onTap: () => _selectDate(context),
                        readOnly: true,
                        controller: birthDateController,
                        style: const TextStyle(
                          color: AppColorsLight.secondaryColor,
                          fontSize: 12,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your Birthdate!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.withAlpha(25),
                          prefixIcon: const Icon(Icons.date_range_rounded),
                          enabledBorder: customOutlineInputBorder(),
                          border: customOutlineInputBorder(),
                          focusedBorder: customOutlineInputBorder(),
                          hintText: "Birthdate",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          contentPadding: const EdgeInsets.all(12),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            GoRouter.of(context)
                                .push(AppRouter.verificationView);
                            // if (formKey.currentState!.validate()) {
                            //   // Registeration Code

                            // }
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
                            "Register",
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
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
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ShapeDecoration selectionDecoration(Color color) {
    return ShapeDecoration(
      color: color,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
    );
  }

  OutlineInputBorder customOutlineInputBorder() {
    return const OutlineInputBorder(
      // borderSide: BorderSide(color: AppColorsLight.secondaryColor),
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      birthDateController.text = picked.toString().split(" ")[0];
    }
  }
}
