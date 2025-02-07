import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_cart_app/core/themes/light_theme/app_colors_light.dart';

class OtpForm extends StatelessWidget {
  OtpForm({super.key});
  final pin1 = TextEditingController();
  final pin2 = TextEditingController();
  final pin3 = TextEditingController();
  final pin4 = TextEditingController();
  String code = "";
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextFormField(
                  controller: pin1,
                  onSaved: (pin) {},
                  onChanged: (pin) {
                    if (pin.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "-",
                    hintStyle: const TextStyle(color: Color(0xFF757575)),
                    border: authOutlineInputBorder,
                    enabledBorder: authOutlineInputBorder,
                    focusedBorder: authOutlineInputBorder.copyWith(
                      borderSide:
                          const BorderSide(color: AppColorsLight.primaryColor),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: pin2,
                  onSaved: (pin) {},
                  onChanged: (pin) {
                    if (pin.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "-",
                    hintStyle: const TextStyle(color: Color(0xFF757575)),
                    border: authOutlineInputBorder,
                    enabledBorder: authOutlineInputBorder,
                    focusedBorder: authOutlineInputBorder.copyWith(
                      borderSide:
                          const BorderSide(color: AppColorsLight.primaryColor),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: pin3,
                  onSaved: (pin) {},
                  onChanged: (pin) {
                    if (pin.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "-",
                    hintStyle: const TextStyle(color: Color(0xFF757575)),
                    border: authOutlineInputBorder,
                    enabledBorder: authOutlineInputBorder,
                    focusedBorder: authOutlineInputBorder.copyWith(
                      borderSide:
                          const BorderSide(color: AppColorsLight.primaryColor),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: pin4,
                  onSaved: (pin) {},
                  onChanged: (pin) {
                    if (pin.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                      print(pin1.text + pin2.text + pin3.text + pin4.text);
                      code = pin1.text + pin2.text + pin3.text + pin4.text;
                    }
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "-",
                    hintStyle: const TextStyle(color: Color(0xFF757575)),
                    border: authOutlineInputBorder,
                    enabledBorder: authOutlineInputBorder,
                    focusedBorder: authOutlineInputBorder.copyWith(
                      borderSide:
                          const BorderSide(color: AppColorsLight.primaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                //Send Code
              },
              style: ButtonStyle(
                backgroundColor:
                    const WidgetStatePropertyAll(AppColorsLight.primaryColor),
                foregroundColor: const WidgetStatePropertyAll(Colors.white),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              child: const Text("Continue"),
            ),
          )
        ],
      ),
    );
  }
}

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xFF757575)),
  borderRadius: BorderRadius.all(Radius.circular(12)),
);
