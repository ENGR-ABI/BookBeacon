import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyController extends GetxController {
  static VerifyController get inst => Get.find();
  final canResend = RxBool(false);
  final canVerify = RxBool(false);
  final intervalUntilResend = RxInt(30);
  final List<FocusNode> otpFocusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  final List<TextEditingController> textFieldControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  void onInit() {
    for (var textFieldController in textFieldControllers) {
      textFieldController.addListener(() {});
    }
    beginCountDown();
    super.onInit();
  }

  final functionURL = 'https://us-central1-abswipe-app.cloudfunctions.net';

  @override
  void onClose() {
    for (var textFocusNode in otpFocusNodes) {
      textFocusNode.dispose();
    }
    for (var otpTextController in textFieldControllers) {
      otpTextController.dispose();
    }
    super.onClose();
  }

  FocusNode currentFocusNode(int index) => otpFocusNodes[index];

  void requestFocus(String value, int currentFocused) {
    if (value == '') {
      canVerify.value = false;
      if (currentFocused == 0) {
        return;
      }
      otpFocusNodes[currentFocused - 1].requestFocus();
    } else {
      (currentFocused == 5) ? null : otpFocusNodes[currentFocused].nextFocus();
      String otpValues = getOTP();
      (otpValues.length != 6)
          ? canVerify.value = false
          : canVerify.value = true;
    }
  }

  String getOTP() {
    String otpValue = '';
    for (TextEditingController controller in textFieldControllers) {
      otpValue += controller.text;
    }
    return otpValue;
  }

  void close() {
    clearFields();
    Get.back();
    VerifyController().dispose();
  }

  void beginCountDown() {
    int currentInterval = intervalUntilResend.value;
    canResend.value = false;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (intervalUntilResend.value != 0) {
        intervalUntilResend.value--;
      } else {
        timer.cancel();
        canResend.value = true;
        intervalUntilResend.value = currentInterval;
      }
    });
  }

  void fillTextFields(String? smsCode) {
    if (smsCode != null) {
      final codeOneByOne = smsCode.split('');
      for (int i = 0; i < textFieldControllers.length; i++) {
        textFieldControllers[i].text = codeOneByOne[i];
      }
    }
  }

  FocusNode getTextFocusNode(int index) => otpFocusNodes[index];

  void nextFocusNode(String value, int currentFocusedNode) async {
    if (value == '') {
      canVerify.value = false;
      if (currentFocusedNode == 0) {
        return;
      }
      otpFocusNodes[currentFocusedNode - 1].requestFocus();
    } else {
      otpFocusNodes[currentFocusedNode].nextFocus();
      if (currentFocusedNode == 5) {
        canVerify.value = true;
      } else {
        canVerify.value = false;
      }
    }
  }

  String getOtpCodes() {
    String otpValues = '';
    for (var otpController in textFieldControllers) {
      if (otpController.text != '') {
        otpValues += otpController.text;
      }
    }
    return otpValues;
  }

  void clearFields() {
    for (var controller in textFieldControllers) {
      controller.text = '';
    }
    otpFocusNodes[0].requestFocus();
  }

  // Future<bool> sendOTP(String to) async {
  //   try {
  //     final url = '$functionURL/otpSender/sendOTP';
  //     final authToken = await authController.currentStaff!.getIdToken();
  //     final headers = {
  //       'Authorization': 'Bearer $authToken',
  //       'Content-Type': 'application/x-www-form-urlencoded',
  //     };
  //     final response = await abswipeAPI.post(
  //       url,
  //       {'to': to},
  //       headers: headers,
  //     );
  //     if (response != null && response['status'] == 200) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (_) {
  //     return false;
  //   }
  // }

  // Future<bool> verifyOTP(String to, String code) async {
  //   final authToken = await authController.currentStaff!.getIdToken();
  //   final headers = {
  //     'Authorization': 'Bearer $authToken',
  //     'Content-Type': 'application/x-www-form-urlencoded',
  //   };
  //   final data = {
  //     "to": to,
  //     "code": code,
  //   };
  //   try {
  //     final response = await abswipeAPI
  //         .post('$functionURL/otpSender/verifyOTP', data, headers: headers);
  //     if (response != null && response['status'] == 'approved') {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (_) {
  //     return false;
  //   }
  // }
}
