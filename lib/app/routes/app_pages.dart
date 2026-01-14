import 'package:get/get.dart';

import '../modules/datetimewidget/bindings/datetimewidget_binding.dart';
import '../modules/datetimewidget/views/datetimewidget_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/popupmenuanddropdownmenu/bindings/popupmenuanddropdownmenu_binding.dart';
import '../modules/popupmenuanddropdownmenu/views/popupmenuanddropdownmenu_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.POPUPMENUANDDROPDOWNMENU;

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
  ];
}
