import 'package:get/get.dart';

import '../modules/datetimewidget/bindings/datetimewidget_binding.dart';
import '../modules/datetimewidget/views/datetimewidget_view.dart';
import '../modules/download_files/bindings/download_files_binding.dart';
import '../modules/download_files/views/download_files_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/popup-dropdown/bindings/popupmenuanddropdownmenu_binding.dart';
import '../modules/popup-dropdown/views/popupmenuanddropdownmenu_view.dart';
import '../modules/textformfield/bindings/textformfield_binding.dart';
import '../modules/textformfield/views/textformfield_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DOWNLOAD_FILES;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DATETIMEWIDGET,
      page: () => const DatetimewidgetView(),
      binding: DatetimewidgetBinding(),
    ),
    GetPage(
      name: _Paths.POPUPMENUANDDROPDOWNMENU,
      page: () => const PopupmenuanddropdownmenuView(),
      binding: PopupmenuanddropdownmenuBinding(),
    ),
    GetPage(
      name: _Paths.TEXTFORMFIELD,
      page: () => const TextformfieldView(),
      binding: TextformfieldBinding(),
    ),
    GetPage(
      name: _Paths.DOWNLOAD_FILES,
      page: () =>  DownloadView(),
      binding: DownloadFilesBinding(),
    ),
  ];
}
