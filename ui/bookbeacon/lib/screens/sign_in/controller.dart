import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/config/constants.dart';
import '../../app/controllers/app_controller.dart';
import '../../app/controllers/verify_controller.dart';
import '../../app/layout/layout_controller.dart';
import '../../app/models/country.dart';
import '../../utils/utills.dart';
import '../../widgets/items_selector.dart';
import 'screens/sign_in.dart';
import 'state.dart';
import 'verification.dart';

class SignInController extends GetxController {
  final state = SignInState();
  final layout = LayoutController.inst;
  final appCTRL = AppController.inst;
  final TextEditingController phoneNumberCTR = TextEditingController();
  final GlobalKey<FormState> withPhoneFormKey = GlobalKey<FormState>();
  final inputError = ''.obs;
  late Country _activeCountry;
  Country get activeCountry => _activeCountry;
  SignInController();

  List<Widget> get pages => [
        const SignInPage(),
      ];

  @override
  void onInit() {
    _activeCountry = Country(
      name: 'India',
      code: 'IN',
      dialCode: '+91',
      flag: Utils.countryCodeToEmoji('IN'),
    );

    super.onInit();
  }

  /// Signing with email
  /// Else with phone number
  void signIn() async {
      if (withPhoneFormKey.currentState!.validate()) {
        final phoneNum =
            '${AppController.inst.activeCountry.value.dialCode}${phoneNumberCTR.text}';
        AppController.inst.showLoading(initialLoadingText: 'Verifying...');
        await withPhoneNumber(phoneNum);
      }
  }

  void signUp() async {
      if (withPhoneFormKey.currentState!.validate()) {
        final phoneNum =
            '${AppController.inst.activeCountry.value.dialCode}${phoneNumberCTR.text}';
        AppController.inst
            .showLoading(initialLoadingText: 'Creating an account');
        await withPhoneNumber(phoneNum);
      }
  }

  void selectCountry() {
    Get.dialog(
      barrierColor: Colors.black.withOpacity(0.4),
      ItemsSelector(
        title: 'Select Country',
        constraints: const BoxConstraints(
            minWidth: 380.0, minHeight: 400, maxHeight: 400),
        alignment: Alignment.centerLeft,
        items: AppController.inst.countries
            .map((e) => ItemModel(
                  leading: Text(e.flag),
                  item: e.name,
                  id: e.code,
                  trailing: Text(
                    e.dialCode,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ))
            .toList(),
        onSingleSelect: setCountry,
      ),
    );
  }

  void setCountry(ItemModel? selectedCountry) {
    if (selectedCountry == null) return;
    var selected = AppController.inst.countries
        .where((country) => country.name == selectedCountry.item)
        .first;
    AppController.inst.activeCountry.value = selected;
  }

  void changeState() {
    if (state.index.value == pages.length - 1) {
      state.index--;
    } else {
      state.index++;
    }
  }

  // Future<void> signInWithEmailAndPassword(
  //     String emailAddress, String password) async {
  //   try {
  //     final credential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: emailAddress, password: password);
  //     if (credential.user?.uid != null) {
  //       final qaaria = await fetchQaaria(credential.user!.uid);
  //       if (qaaria == null) {
  //         AppController.inst
  //           ..stopLoading()
  //           ..showSnackbar(ACCOUNT_PROBLEM_MESSAGE, color: Constants.danger);
  //       } else {
  //         await CacheStore.inst.saveProfile(qaaria);
  //         Get.offAllNamed(AppRoutes.dashBoard);
  //       }
  //     } else {
  //       AppController.inst
  //           .showSnackbar(ACCOUNT_PROBLEM_MESSAGE, color: Constants.danger);
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     print(e.message);
  //     AppController.inst.handleFirebaseAuthException(e);
  //   }
  // }

  Future<void> withPhoneNumber(String phoneNumber) async {
    if (kIsWeb) {
      Get.back();
    } else {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {
          VerifyController.inst.fillTextFields(phoneAuthCredential.smsCode);
          await _signInWithPhoneAuthCred(phoneAuthCredential);
        },
        verificationFailed: (FirebaseAuthException error) {
          AppController.inst.stopLoading();
          if (error.code == 'invalid-phone-number') {
            AppController.inst.showSnackbar(
              'Invalid phone number entered',
              color: Constants.danger,
            );
          }
        },
        codeSent: (verificationId, forceResendingToken) async {
          AppController.inst.showButtomSheet(Verification(
            whichtoVerify: phoneNumber,
            onVerify: (smsCode) async {
              final credential = PhoneAuthProvider.credential(
                  verificationId: verificationId, smsCode: smsCode);
              await _signInWithPhoneAuthCred(credential);
            },
          ));
        },
        codeAutoRetrievalTimeout: (verificationId) {
          print('Auto retrievaal failed: $verificationId');
        },
      );

      Get.dialog(
        Verification(
            whichtoVerify: phoneNumber,
            onVerify: (code) {
              AppController.inst.showOverlayMessage(message: code);
            }),
        barrierColor: Colors.transparent,
      );
    }
  }

  // Future<void> _signInWithPhoneAuthCred(
  //     PhoneAuthCredential phoneAuthCredential) async {
  //   try {
  //     await FirebaseAuth.instance
  //         .signInWithCredential(phoneAuthCredential)
  //         .then((UserCredential userCredential) async {
  //       //await fetchCurrentUserInfo(userCredential.user);
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     AppController.inst.stopLoading();
  //     if (e.code == 'invalid-verification-code') {
  //       AppController.inst.showSnackbar(
  //         'Invalid code entered',
  //         color: Constants.danger,
  //       );
  //     } else {
  //       AppController.inst.handleFirebaseAuthException(e);
  //     }
  //   }
  // }

  _signInWithPhoneAuthCred(PhoneAuthCredential credential) {}
}
