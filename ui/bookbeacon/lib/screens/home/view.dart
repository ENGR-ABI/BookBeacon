import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/globals.dart';
import 'controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeWidget(),
    );
  }
}

class HomeWidget extends GetView<HomePageController> {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().screenHeight,
      decoration: const BoxDecoration(),
      child: Obx(
        () => Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 300,
                ),
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/icon/book-beacon-reader-r.png'),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Align(
              alignment: controller.layout.isPhone(context)
                  ? Alignment.bottomLeft
                  : Alignment.centerLeft,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: controller.layout.isPhone(context) ? 20 : 40),
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  constraints: const BoxConstraints(
                    maxWidth: 420,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enjoy Your Favourite Books',
                        style: Get.textTheme.displaySmall?.copyWith(
                          fontSize: 24,
                        ),
                      ),
                      14.verticalSpace,
                      Text(
                        'Book Beacon',
                        style: Get.textTheme.displaySmall?.copyWith(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Globals.colorScheme.primary,
                        ),
                      ),
                      8.verticalSpace,
                      Text('Where Stories Shine: BookBeacon Leads the Way.',
                          style: Get.textTheme.bodyMedium?.copyWith()),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: controller.toDashBoardScreen,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Globals.colorScheme.primary,
                          foregroundColor: Globals.colorScheme.onPrimary,
                        ),
                        child: const Text('Get Started'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
