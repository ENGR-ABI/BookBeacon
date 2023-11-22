import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
    TextSpan(text: 'By entering your number, you agree to our ', children: [
      TextSpan(
        text: 'Terms & Conditions ',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Get.theme.colorScheme.primary,
        ),
      ),
      const TextSpan(text: 'and '),
      TextSpan(
        text: 'Privacy Policy ',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Get.theme.colorScheme.primary,
        ),
      ),
      const TextSpan(text: 'thanks '),
    ]),
    textAlign: TextAlign.center,
  );
  }
}