import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:bookbeacon/app/data/countries_list.dart';
import 'package:bookbeacon/app/layout/layout_controller.dart';
import 'package:bookbeacon/app/models/country.dart';
import 'package:bookbeacon/app/theme/theme_controller.dart';
import 'package:bookbeacon/utils/dimensions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:popover_gtk/popover_gtk.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/loading_widget.dart';
import '../config/constants.dart';
import '../data/firebase_auth_exception.dart';
import '../services/app_preferences.dart';
import '../config/initial_preferences.dart';

class AppController extends GetxService {
  @override
  void onInit() {
    countries =
        countriesMap.map((country) => Country.fromMap(country)).toList();
    _activeCountry =
        Rx(countries.where((country) => country.code == 'IN').first);
    super.onInit();
  }

  static AppController get inst => Get.find();
  final layout = LayoutController.inst;
  final themeCTRL = ThemeController.inst;
  late List<Country> countries;
  late Rx<Country> _activeCountry;
  // ignore: unnecessary_getters_setters
  Rx<Country> get activeCountry => _activeCountry;
  set activeCountry(Rx<Country> country) => _activeCountry = country;

  static final random = Random();
  final loadingMessage = "Please wait...".obs;

  Future<void> launchAppropriateScreen() async {
    final isFirstLaunch = await AppPreferences.getAny('isFirstLaunch');
    await Future.delayed(const Duration(seconds: 3));
    if (isFirstLaunch == null) {
      await AppPreferences.addPrefs(initialPreferences);
      Get.offAndToNamed('/getStarted');
    } else {
      //Get.offAndToNamed('/homepage');
    }
  }

  static Future<ThemeMode> getThemeMode() async {
    final themeMode = await AppPreferences.getAny('themeMode');
    if (themeMode == 'light') {
      return ThemeMode.light;
    } else if (themeMode == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  static int genOTP() {
    int otp = random.nextInt(1000000 - 6 + 1) + 6;
    if (otp.toString().length < 6) {
      otp = random.nextInt(1000000 - 6 + 1) + 6;
    }
    return otp;
  }

  void showOverlayMessage({required String message}) {
    Get.dialog(
      barrierColor: ThemeController.inst.activeTheme.value.colorScheme.onSurface
          .withOpacity(0.8),
      Center(
        child: SizedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.getResValFromWidth(20)),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showQuestionDialog(
      {required String title,
      required String message,
      required VoidCallback onConfirm,
      String? onConfimText,
      VoidCallback? onCancel}) {
    Get.dialog(
      //barrierDismissible: false,
      //barrierColor: colorScheme.background.withOpacity(0.1),
      name: 'Confirm Dialog',
      Center(
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          elevation: 4,
          margin: EdgeInsets.all(Dimensions.getResValFromWidth(20)),
          child: Container(
            width: Dimensions.screenWidth,
            height: Dimensions.divideScreenBy(5.5) + message.length.toDouble(),
            padding: EdgeInsets.fromLTRB(
                Dimensions.getResValFromWidth(20),
                Dimensions.getResValFromWidth(20),
                Dimensions.getResValFromWidth(20),
                Dimensions.getResValFromWidth(10)),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Get.textTheme.displaySmall!.copyWith(
                      fontSize: Dimensions.getResValFromWidth(18),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 6,
                ),
                const Divider(),
                Expanded(
                  child: Text(message),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                        child: TextButton(
                      child: const Text('Cancel'),
                      onPressed: () => onCancel ?? Get.back(),
                    )),
                    _spacer(),
                    Flexible(
                        child: TextButton(
                      child: const Text('Confirm'),
                      onPressed: () => onConfirm(),
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _spacer() {
    return Row(
      children: [
        const SizedBox(
          width: 4,
        ),
        SizedBox(
          width: 1,
          child: Divider(
            color: themeCTRL.activeTheme.value.colorScheme.primary,
            thickness: 12,
          ),
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  void showLoading({bool allowBackButton = false, String? initialLoadingText}) {
    if (initialLoadingText != null) {
      loadingMessage.value = initialLoadingText;
    }
    Get.dialog(
      barrierDismissible: allowBackButton,
      name: 'loading',
      LoadingWidget(
        dismissible: allowBackButton,
        loadingText: loadingMessage.value,
      ),
    );
  }

  void stopLoading() => Get.back();

  void showButtomSheet(
    Widget bottomsheet, {
    Color? backgroundColor,
    double? elevation,
    bool persistent = true,
    ShapeBorder? shape,
    Color? barrierColor,
    bool isDismissible = false,
    bool enableDrag = false,
    bool isScrollControlled = true,
    bool allowBackButton = false,
    String? routeName,
  }) {
    shape ??= RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Dimensions.getResValFromHeight(30)),
        topRight: Radius.circular(Dimensions.getResValFromHeight(30)),
      ),
    );
    Get.bottomSheet(
      backgroundColor: backgroundColor,
      elevation: elevation,
      persistent: persistent,
      shape: shape,
      barrierColor: barrierColor,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: isScrollControlled,
      settings: RouteSettings(name: routeName ?? 'defaultBottomSheet'),
      WillPopScope(
        onWillPop: () async => allowBackButton,
        child: bottomsheet,
      ),
    );
  }

  void closeBottomSheet() {
    bool? isBottomSheetOpen = Get.isBottomSheetOpen;
    if (isBottomSheetOpen != null) {
      if (isBottomSheetOpen) {
        Get.back();
      }
    }
  }

  void showErrorSnack({String? title = 'Oops', required String mesaage}) {
    HapticFeedback.mediumImpact();
    Get.snackbar(
      title!,
      mesaage,
      icon: const Icon(Icons.error),
      borderRadius: Dimensions.getResValFromWidth(30),
      isDismissible: true,
      backgroundColor: themeCTRL.activeTheme.value.colorScheme.errorContainer,
      colorText: themeCTRL.activeTheme.value.colorScheme.onErrorContainer,
    );
  }

  showSnackbar(
    String message, {
    String title = '',
    Icon? icon,
    SnackPosition position = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 3),
    bool autohide = true,
    Color color = Colors.blueAccent,
    VoidCallback? onCancel,
  }) {
    Get.showSnackbar(GetSnackBar(
      message: message,
      icon: icon,
      mainButton: !autohide
          ? IconButton(
              onPressed: Get.back,
              icon: const Icon(Icons.close),
              color: Get.theme.colorScheme.onPrimary,
            )
          : null,
      maxWidth: 400,
      snackPosition: position,
      borderRadius: 10,
      backgroundColor: color,
      duration: duration,
    ));
  }

  void showSuccesSnack({String? title = 'Correct!', required String mesaage}) {
    Get.snackbar(
      title!,
      mesaage,
      icon: const Icon(Icons.check_circle),
      borderRadius: Dimensions.getResValFromWidth(30),
      backgroundColor: themeCTRL.activeTheme.value.colorScheme.tertiary,
      colorText: themeCTRL.activeTheme.value.colorScheme.onTertiary,
    );
  }

  void handleFireStoreException(Object exception) {
    debugPrint(exception.toString());
  }

  void handleFirebaseAuthException(FirebaseAuthException e) {
    stopLoading();
    for (Map<String, String> firebaseAuthException in firebaseAuthExceptions) {
      if (firebaseAuthException['code'].toString() == e.code) {
        showSnackbar(
          firebaseAuthException['message'] as String,
          color: Constants.danger,
        );
        return;
      }
    }
    showOverlayMessage(
        message: 'An internal error has occurred, please contact us.');
  }

  Future<String> loadAsset(String assetPath, {String? newFileName}) async {
    final assetData = await rootBundle.load(assetPath);
    final bytes = assetData.buffer.asUint8List();
    return _storeAndGetPath(assetPath, bytes, newFileName: newFileName);
  }

  Future<String> _storeAndGetPath(String path, Uint8List bytes,
      {String? newFileName}) async {
    String fileName;
    if (newFileName != null && newFileName.isNotEmpty) {
      fileName =
          newFileName + path.substring(path.lastIndexOf('.'), path.length);
    } else {
      fileName = path.substring(path.lastIndexOf('/') + 1, path.length);
    }

    final Directory appDocument = await getApplicationDocumentsDirectory();

    final file = File('${appDocument.path}/$fileName');
    await file.writeAsBytes(bytes);
    return file.path;
  }

  Future<void> launchExtUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  showPopOverWidget({required BuildContext context, required Widget child}) {
    showPopover(
      context: context,
      transitionDuration: const Duration(milliseconds: 150),
      bodyBuilder: (context) =>  child,
    );
  }
}
