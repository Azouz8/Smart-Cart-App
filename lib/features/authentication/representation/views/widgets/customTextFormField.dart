import 'package:flutter/material.dart';
import 'package:smart_cart_app/core/themes/light_theme/app_colors_light.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      required this.controller,
      required this.label,
      required this.validator,
      required this.prefixIcon,
      this.obsecureText,
      this.onSubmit,
      this.type,
      this.enabled,
      this.suffixIcon});
  Icon prefixIcon;
  IconButton? suffixIcon;
  String? Function(String?)? validator;
  String? Function(String?)? onSubmit;
  String label;
  TextEditingController controller = TextEditingController();
  bool? obsecureText;
  TextInputType? type;
  bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // onTapOutside: (event) {
      //   FocusManager.instance.primaryFocus?.unfocus();
      // },
      controller: controller,
      validator: validator,
      onFieldSubmitted: onSubmit,
      obscureText: obsecureText ?? false,
      keyboardType: type,
      enabled: enabled,
      style: const TextStyle(
        color: AppColorsLight.secondaryColor,
        fontSize: 12,
      ),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: customOutlineInputBorder(),
        border: customOutlineInputBorder(),
        focusedBorder: customOutlineInputBorder(),
        hintText: label,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
        contentPadding: const EdgeInsets.all(12),
      ),
    );
  }

  OutlineInputBorder customOutlineInputBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(color: AppColorsLight.secondaryColor),
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
    );
  }
}
