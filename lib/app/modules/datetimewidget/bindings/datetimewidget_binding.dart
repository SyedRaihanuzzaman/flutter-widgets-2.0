import 'package:get/get.dart';

import '../controllers/datetimewidget_controller.dart';

class DatetimewidgetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatetimewidgetController>(
      () => DatetimewidgetController(),
    );
  }
}
