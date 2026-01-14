import 'package:get/get.dart';

import '../controllers/popupmenuanddropdownmenu_controller.dart';

class PopupmenuanddropdownmenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PopupmenuanddropdownmenuController>(
      () => PopupmenuanddropdownmenuController(),
    );
  }
}
