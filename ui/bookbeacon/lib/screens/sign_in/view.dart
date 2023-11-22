import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'screens/sign_in.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: Get.focusScope?.unfocus,
        child: SizedBox(
          height: ScreenUtil().screenHeight,
          child: Stack(
            children: [
              Align(
              alignment: Alignment.topRight,
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 300,
                ),
                height: 300,
                decoration: const BoxDecoration(
image: DecorationImage(image: AssetImage('assets/icon/book-beacon-reader-r.png'), fit: BoxFit.fill),
                ),
              ),
            ),
              Align(
                alignment: controller.appCTRL.layout.isPhone(context)
                    ? Alignment.bottomCenter
                    : (controller.appCTRL.layout.isComputer(context) ||
                            controller.layout.isLargeTablet(context))
                        ?
                          Alignment.centerLeft
                        : controller.layout.isTablet(context)
                            ? Alignment.bottomLeft
                            : Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal:
                            controller.layout.isPhone(context) ? 20 : 40),
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    constraints: const BoxConstraints(
                      maxWidth: 400,
                    ),
                    child: const SignInPage(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*

SizedBox(
                        child: Container(
                          margin: controller.layout.isPhone(context)
                              ? const EdgeInsets.only(top: 20).h
                              : controller.layout.isTablet(context)
                                  ? const EdgeInsets.only(
                                          top: 40, left: 40, right: 40)
                                      .h
                                  : const EdgeInsets.only(
                                          top: 30, bottom: 30, right: 30)
                                      .h,
                          padding: const EdgeInsets.all(20).h,
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)).r,
                          ),
                          constraints: BoxConstraints(
                            minHeight: controller.layout.isPhone(context)
                                ? 0.8.sh - 22
                                : 0.7,
                          ),
                          child: Obx(
                            () =>
                                controller.pages[controller.state.index.value],
                          ),
                        ),
                      ),
                      */