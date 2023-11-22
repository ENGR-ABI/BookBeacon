import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller.dart';
import '../widgets/phone_number_input.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        const Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                'Welcome Back',
                style: TextStyle(fontSize: 22),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Get into your account by entering your number below',
              ),
            ),
          ],
        ),
        controller.layout.isPhone(context)
            ? const SizedBox(
                height: 14,
              )
            : const SizedBox(
                height: 20,
              ),

        /// Inputs Widgets
        PhoneNumberInput(controller: controller),
        controller.layout.isPhone(context)
            ? const SizedBox(
                height: 14,
              )
            : const SizedBox(
                height: 20,
              ),
        /// Buttons
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.signIn,
                child: const Text('Sign In'),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
          ],
        ),
      ],
    );
  }
}
