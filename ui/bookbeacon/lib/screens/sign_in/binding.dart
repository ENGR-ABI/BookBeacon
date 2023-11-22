import 'package:get/instance_manager.dart';
import '../../app/controllers/inputs_validator.dart';
import '../../app/layout/layout_controller.dart';
import 'controller.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LayoutController());
    Get.lazyPut<SignInController>(() => SignInController());
    Get.put(InputsValidator());
  }
}
