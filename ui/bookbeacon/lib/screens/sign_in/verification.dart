import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../app/controllers/app_controller.dart';
import '../../app/controllers/verify_controller.dart';
import '../../utils/globals.dart';
import '../../widgets/dialog/dialog.dart';

class Verification extends StatelessWidget {
  Verification({super.key, required this.whichtoVerify, required this.onVerify});

  final AppController appController = Get.find<AppController>();
  final VerifyController verifyController = Get.put(VerifyController());
  final String whichtoVerify;
  final ValueChanged<String> onVerify;
  final RxBool canResend = RxBool(false);
  final RxInt counter = RxInt(60);
  final RxBool isResending = RxBool(false);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _startCountDown(),
    );
    return WillPopScope(
      onWillPop: () async => false,
      child: IqraaDialog(
        title: 'Authentication',
        titleIcon: Icon(
          Icons.lock_person,
          color:Globals. colorScheme.onPrimary,
        ),
        contents: [
          SizedBox(
            child: Text('Six digits code has been sent to',
                textAlign: TextAlign.center,
                style: Get.textTheme.bodyMedium!.copyWith(
                  fontSize: 14,
                )),
          ),
          10.verticalSpace,
          SizedBox(
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => Get.close(2),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: '$whichtoVerify ',
                    style: Get.textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Globals.colorScheme.primary,
                    ),
                    children: const [
                      TextSpan(text: ' ✎', style: TextStyle(fontSize: 20))
                    ],
                  )),
            ),
          ),
          14.verticalSpace,
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            children: List.generate(
              6,
              (index) => SizedBox.square(
                dimension: 28,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: verifyController.textFieldControllers[index],
                  focusNode: verifyController.otpFocusNodes[index],
                  textInputAction: (index != 5)
                      ? TextInputAction.next
                      : TextInputAction.done,
                  onChanged: (value) {
                    verifyController.nextFocusNode(value, index);
                    if (index == 5 && value.isNotEmpty) {
                      _verify();
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(
                      RegExp(r'\D$'),
                    ),
                  ],
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  autofocus: (index == 0) ? true : false,
                  decoration: const InputDecoration(
                    counterText: '',
                    filled: true,
                    isDense: true,
                    contentPadding: EdgeInsets.all(2),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ),

          // Obx(
          //   () => TextButton(
          //     onPressed:
          //         verifyController.canResend.isTrue ? _resendOTP : null,
          //     style: TextButton.styleFrom(
          //       padding: EdgeInsets.symmetric(
          //           vertical: Dimensions.getResValFromWidth(2),
          //           horizontal: Dimensions.getResValFromWidth(10)),
          //     ),
          //     child: Text(
          //       verifyController.canResend.isFalse
          //           ? 'Code can be resend in ${verifyController.intervalUntilResend.value}'
          //           : 'Resend Code',
          //     ),
          //   ),
          // ),
          14.verticalSpace,
          Obx(
            () => ElevatedButton(
              onPressed: canResend.isFalse ? null : () => _resedCode(),
              child: canResend.isFalse
                  ? Text('Resend Code In ${counter}s')
                  : const Text('Resend Code'),
            ),
          ),
          // 10.verticalSpace,
          // SizedBox(
          //   width: double.infinity,
          //   child: Obx(
          //     () => ElevatedButton(
          //       onPressed:
          //           verifyController.canVerify.isFalse ? null : () => _verify(),
          //       child: const Text('Verify'),
          //     ),
          //   ),
          // ),
          10.verticalSpace,
          TextButton(onPressed: _cancelLogin, child: const Text('Cancel')),
        ],
      ),
    );
  }

  void _verify() {
    final otpValues = verifyController.getOtpCodes();
    verifyController.clearFields();
    onVerify(otpValues);
  }

  _resedCode() async {
    appController.showLoading(initialLoadingText: 'Resending code...');
    // counter.value *= 2;
    // final sent = await verifyController.sendOTP(whichToVerify);
    // appController.stopLoader();
    // if (sent) {
    //   _startCountDown();
    //   isResending.toggle();
    //   canResend.toggle();
    //   appController.showSnackbar(
    //     'Code has been resent successfully.',
    //     color: themeController.activeThemeColors.success,
    //   );
    // } else {
    //   appController.showSnackbar(
    //       'Unable to resend code, please try again later.',
    //       color: themeController.activeThemeColors.error);
    // }
  }

  _startCountDown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter.value != 0) {
        counter.value--;
      } else {
        timer.cancel();
        canResend.toggle();
        counter.value = 60;
      }
    });
  }

  void _cancelLogin() {}
}
