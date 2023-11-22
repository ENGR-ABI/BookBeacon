import 'dart:io';

import 'package:get/get.dart';

class SignInState {
  var index = 0.obs;
  var isEmail = Platform.isAndroid || Platform.isIOS ? false.obs : true.obs;
  var isNumberEnabled = true.obs;
  var isPasswordVisible = true.obs;
}
