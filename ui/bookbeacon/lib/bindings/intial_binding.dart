import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:bookbeacon/app/services/api_service.dart';
import 'package:bookbeacon/app/services/app_storage.dart';
import 'package:bookbeacon/app/controllers/app_controller.dart';
import 'package:bookbeacon/app/services/cache_store.dart';
import 'package:bookbeacon/app/theme/theme_controller.dart';
import 'package:path_provider/path_provider.dart';
import '../app/layout/layout_controller.dart';
import '../app/controllers/auth_controller.dart';
import '../firebase_options.dart';

class InitialBinding {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    Get.put(AuthController());
    await Get.putAsync<AppStorage>(() => AppStorage().initialize());
    await Get.putAsync<ThemeController>(
        () => ThemeController().loadThemeData());
    Get.put(LayoutController());
    Get.put(AppController());
    Get.put(CacheStore());
    Get.lazyPut(() => ApiService());
    String storageLocation = (await getApplicationDocumentsDirectory()).path;
    await FastCachedImageConfig.init(
        subDir: storageLocation, clearCacheAfter: const Duration(days: 15));
  }
}
