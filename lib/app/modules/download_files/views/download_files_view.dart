import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/download_files_controller.dart';

class DownloadView extends GetView<DownloadController> {
  final TextEditingController urlController = TextEditingController();

  DownloadView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Download File')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: urlController,
              decoration: InputDecoration(
                labelText: 'File URL',
                border: OutlineInputBorder(),
                hintText: 'Enter file URL to download',
              ),
            ),
            SizedBox(height: 16),
            Obx(() => ElevatedButton(
              onPressed: controller.isDownloading.value
                  ? null
                  : () => controller.downloadFile(urlController.text, null),
              child: controller.isDownloading.value
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      value: controller.progress.value,
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text('${(controller.progress.value * 100).toStringAsFixed(0)}%'),
                ],
              )
                  : Text('Download'),
            )),
            SizedBox(height: 16),
            Obx(() => controller.isDownloading.value
                ? LinearProgressIndicator(value: controller.progress.value)
                : SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}