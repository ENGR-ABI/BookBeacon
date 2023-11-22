import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dimensions {
  static const double defaultScreenHeight = 844.0;
  static const double defaultScreenWidth = 390.0;
  static double screenHeight = Get.mediaQuery.size.height;
  static double screenView = Get.mediaQuery.size.height -
      AppBar().preferredSize.height -
      kToolbarHeight;

  static double screenWidth = Get.mediaQuery.size.width;

  static double getResValFromHeight(double value) {
    var x = defaultScreenHeight / value;
    return screenHeight / x;
  }

  static double getResValFromWidth(double value) {
    var x = defaultScreenWidth / value;
    return screenWidth / x;
  }

  static double getCenterValue() {
    var x = screenWidth / 2;
    return x / 2;
  }

  static double divideScreenBy(double dividend) => screenView / dividend;
}
