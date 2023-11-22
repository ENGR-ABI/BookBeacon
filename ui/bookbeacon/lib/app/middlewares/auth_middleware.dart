import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:bookbeacon/app/routes/route_names.dart';
import 'package:bookbeacon/app/services/cache_store.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (CacheStore.inst.isLogged) {
      if (route != AppRoutes.dashBoard &&
          !route.toString().contains(AppRoutes.accountSetup)) {
        return route == AppRoutes.dashBoard
          ? null
          : const RouteSettings(name: AppRoutes.dashBoard);
      } else {
        return null;
      }
    } else {
      return route == AppRoutes.dashBoard
          ? const RouteSettings(name: AppRoutes.homePage)
          : null;
    }
  }
}
