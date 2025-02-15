import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:myapp/controllers/signup_controller.dart';
import 'package:myapp/core/utils/constants/colors.dart';
import 'package:myapp/core/utils/constants/imagestrings.dart';
import 'package:myapp/core/utils/constants/textstrings.dart';
import 'package:myapp/core/utils/helpers/helpers.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key, required this.isDarkMode});

  final bool isDarkMode;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.userFirstName,
                    validator: (value) =>
                        THelper.validateTextFields('firstName', value!),
                    style: TextStyle(fontSize: 16),
                    cursorColor: TColors.primaryColor,
                    decoration: const InputDecoration(
                      labelText: TTextstrings.userFirstName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    validator: (value) =>
                        THelper.validateTextFields('lastName', value!),
                    controller: controller.userName,
                    style: TextStyle(fontSize: 16),
                    cursorColor: TColors.primaryColor,
                    decoration: const InputDecoration(
                      labelText: TTextstrings.userLastName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
           TextFormField(
            controller: controller.userName,
            validator: (value) =>
                        THelper.validateTextFields('lastName', value!),
            style: TextStyle(fontSize: 16),
            cursorColor: TColors.primaryColor,
            decoration: const InputDecoration(
              labelText: TTextstrings.userName,
              prefixIcon: Icon(Iconsax.user),
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: controller.email,
            validator: (value) => THelper.isValidEmail(value),
            style: TextStyle(fontSize: 16),
            cursorColor: TColors.primaryColor,
            decoration: const InputDecoration(
              labelText: TTextstrings.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: controller.phoneNumber,
  validator: (value) => THelper.validatePhoneNumber(value), // Checks validity
  onChanged: (value) {
    controller.phoneNumber.text = THelper.formatPhoneNumber(value); // Formats to Kenyan format
  },
            style: TextStyle(fontSize: 16),
            cursorColor: TColors.primaryColor,
            decoration: const InputDecoration(
              labelText: TTextstrings.phoneNumber,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: 15),
          Obx(()=>
             TextFormField(
              controller: controller.password,
              validator: (value) => THelper.validatePassword(value),
              style: TextStyle(fontSize: 16),
              cursorColor: TColors.primaryColor,
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: TTextstrings.password,
                prefixIcon: const Icon(Iconsax.lock),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                  icon: Icon(controller.hidePassword.value? Iconsax.eye_slash:Iconsax.eye),
                  ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
             onPressed: () {
  if (controller.formKey.currentState!.validate()) {
    controller.signupUser();
  }
},

              child: Text(
                TTextstrings.signUp,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(
                    color: isDarkMode ? Colors.white : Colors.black87),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  TImageStrings.google,
                  height: 24.0,
                ),
                const SizedBox(width: 8.0),
                Text(
                  TTextstrings.signUpWith,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
