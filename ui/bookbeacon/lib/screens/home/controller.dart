import 'package:get/get.dart';
import '../../app/controllers/app_controller.dart';
import '../../app/layout/layout_controller.dart';
import '../../app/routes/route_names.dart';
import 'state.dart';

class HomePageController extends GetxController {
  final state = HomePageState();
  final layout = LayoutController.inst;
  final AppController appController = AppController.inst;

  
  void toSignScreen() {
    Get.toNamed(AppRoutes.getStarted);
  }

  void toDashBoardScreen() {
    Get.toNamed(AppRoutes.dashBoard);
  }
}
