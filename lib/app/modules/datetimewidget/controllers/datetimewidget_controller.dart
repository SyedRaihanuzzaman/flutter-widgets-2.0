import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DatetimewidgetController extends GetxController {
  Rx<DateTime> pickDate = DateTime.now().obs;
  Rx<TimeOfDay> pickTime = TimeOfDay.now().obs;

  void updateDate(DateTime date) {
    pickDate.value = date;
  }

  void updateTime(TimeOfDay time) {
    pickTime.value = time;
  }
}
