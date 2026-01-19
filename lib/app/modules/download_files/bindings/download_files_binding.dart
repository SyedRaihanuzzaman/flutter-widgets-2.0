import 'package:get/get.dart';

import '../controllers/download_files_controller.dart';

class DownloadFilesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DownloadController>(
      () => DownloadController(),
    );
  }
}
