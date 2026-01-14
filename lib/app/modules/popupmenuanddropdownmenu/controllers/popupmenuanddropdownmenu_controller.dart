import 'package:get/get.dart';

class PopupmenuanddropdownmenuController extends GetxController {

  RxInt selectedIndex = 0.obs;

  RxList<String> days = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ].obs;

}
