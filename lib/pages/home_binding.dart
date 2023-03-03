import 'package:get/get.dart';
import 'package:pizza_rapida/pages/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
