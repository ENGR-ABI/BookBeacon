import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/routes/route_screens.dart';
import 'app/theme/theme_controller.dart';
import 'bindings/intial_binding.dart';

Future<void> main(w) async {
  await InitialBinding.init();

  runApp(const BookBeaconApp());
}

class BookBeaconApp extends StatelessWidget {
  const BookBeaconApp({
    super.key,
  });

  static final GlobalKey<NavigatorState> navigatorKey = Get.key;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      //splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return Obx(() => GetMaterialApp(
              theme: ThemeController.inst.lightTheme,
              darkTheme: ThemeController.inst.darkTheme,
              debugShowCheckedModeBanner: false,
              themeMode: ThemeController.inst.themeMode.value,
              getPages: AppScreens.routes,
            ));
      },
    );
  }
}
