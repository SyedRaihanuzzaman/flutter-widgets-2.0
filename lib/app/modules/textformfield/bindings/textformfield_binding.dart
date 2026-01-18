import 'package:get/get.dart';

import '../controllers/textformfield_controller.dart';

class TextformfieldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TextformfieldController>(
      () => TextformfieldController(),
    );
  }
}
