import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../app/controllers/app_controller.dart';
import '../../../app/controllers/inputs_validator.dart';
import '../../../widgets/privacy_policy.dart';
import '../controller.dart';

class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput({super.key, required this.controller});
  final SignInController controller;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.withPhoneFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.phoneNumberCTR,
            enabled: controller.state.isNumberEnabled.value,
            validator: (value) => InputsValidator.inst.number(value),
            keyboardType: TextInputType.number,
            maxLength: 10,
            textInputAction: TextInputAction.done,
            inputFormatters: [
              FilteringTextInputFormatter.deny(
                RegExp(r'\D$'),
              ),
            ],
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.phone),
              prefixIcon: SizedBox(
                width: 30,
                child: Material(
                  color: Colors.transparent,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  child: InkWell(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    onTap: controller.selectCountry,
                    child: Center(
                      child: Obx(
                        () => Text(
                          AppController.inst.activeCountry.value.flag,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              hintText: '7020304050',
              labelText: 'Phone Number',
              counterText: '',
              filled: true,
              isDense: true,
            ),
          ),
          14.verticalSpace,
          const PrivacyPolicy()
        ],
      ),
    );
  }
}
