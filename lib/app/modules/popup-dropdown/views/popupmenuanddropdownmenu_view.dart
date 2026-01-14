import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/popupmenuanddropdownmenu_controller.dart';

class PopupmenuanddropdownmenuView
    extends GetView<PopupmenuanddropdownmenuController> {
  const PopupmenuanddropdownmenuView({super.key});

  @override
  Widget build(BuildContext context) {
    String selectedValue = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popup and Dropdown Menu'),
        centerTitle: true,

        actions: [
          PopupMenuButton<int>(
            onSelected: (value) {
              print('Value is : $value');
            },
            itemBuilder: (context) {
              return [
                // default style
                // PopupMenuItem(value: 'item1', child: Text("Item 1")),
                // PopupMenuItem(value: 'item2', child: Text("Item 2")),
                // PopupMenuItem(value: 'item3', child: Text("Item 3")),
                for (int i = 1; i <= 10; i++)
                  PopupMenuItem(value: i, child: Text("Item $i")),
              ];
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Default Dropdown",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Center(
            child: Obx(
              () => DropdownButton<int>(
                value: controller.selectedIndex.value,
                items: [
                  for (int i = 0; i < controller.days.length; i++)
                    DropdownMenuItem<int>(
                      value: i,
                      child: Text(controller.days[i]),
                    ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedIndex.value = value;
                  }
                },
              ),
            ),
          ),

          SizedBox(height: 20,),
          Text(
            "Dropdown Button 2 with fixed position",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          DropdownButton2<int>(
            value: controller.selectedIndex.value,
            items: [
              for (int i = 0; i < controller.days.length; i++)
                DropdownMenuItem<int>(
                  value: i,
                  child: Text(controller.days[i]),
                ),
            ],
            onChanged: (value) {
              if (value != null) {
                controller.selectedIndex.value = value;
              }
            },

            dropdownStyleData: DropdownStyleData(
              isOverButton: false, // 👉 always opens BELOW
              offset: const Offset(0, 5), // 👉 little gap for nice look
              maxHeight: 400,
            ),
          ),
        ],
      ),
    );
  }
}
