import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:bookbeacon/app/middlewares/auth_middleware.dart';
import 'package:bookbeacon/screens/home/index.dart';
import '../../screens/dashboard/index.dart';
import '../../screens/sign_in/index.dart';
import 'route_names.dart';

class AppScreens {
  ///
  static final RouteObserver<Route> observer = RouteObserver();

  ///
  static final List<String> history = [];

  ///
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.homePage,
      page: () => const HomePage(),
      binding: HomeBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: AppRoutes.getStarted,
      page: () => const SignInScreen(),
      binding: SignInBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.accountSetup,
    //   page: () => const AccountSetupScreen(),
    //   binding: AccountSetupBinding(),
    //   middlewares: [
    //     AuthMiddleware(),
    //   ],
    // ),
    
    GetPage(
      name: AppRoutes.dashBoard,
      page: () => const DashBoardScreen(),
      binding: DashBoardBinding(),
      // middlewares: [
      //   AuthMiddleware(),
      // ],
    )
  ];
}
