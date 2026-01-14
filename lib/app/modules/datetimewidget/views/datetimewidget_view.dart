import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/datetimewidget_controller.dart';

class DatetimewidgetView extends GetView<DatetimewidgetController> {
  const DatetimewidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Date and Time'), centerTitle: true),
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Working with Date and Time',
              style: TextStyle(fontSize: 24),
            ),

            /// 📅 Date
            Obx(
              () => Text(
                DateFormat('dd-MM-yyyy').format(controller.pickDate.value),
                style: const TextStyle(fontSize: 18),
              ),
            ),

            /// ⏰ Time
            Obx(
              () => Text(
                controller.pickTime.value.format(context),
                style: const TextStyle(fontSize: 18),
              ),
            ),

            /// Pick Date
            ElevatedButton(
              onPressed: () async {
                DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: controller.pickDate.value,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );

                if (date != null) {
                  controller.updateDate(date);
                }
              },
              child: const Text("Pick Date"),
            ),

            /// Pick Time
            ElevatedButton(
              onPressed: () async {
                TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: controller.pickTime.value,
                );

                if (time != null) {
                  controller.updateTime(time);
                }
              },
              child: const Text("Pick Time"),
            ),


            Text("Cupertino Date and TimePicker Widget"),
            Flexible(
              child: CupertinoDatePicker(
                onDateTimeChanged: (DateTime date) {
                  controller.updateDate(date);
                },
              ),
            ),

            Flexible(
              child: CupertinoTimerPicker(
                onTimerDurationChanged: (time) {

                  print(time);

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
