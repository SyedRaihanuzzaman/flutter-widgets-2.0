import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';

@pragma('vm:entry-point')
class DownloadController extends GetxController {
  RxBool isDownloading = false.obs;
  RxDouble progress = 0.0.obs;
  String? lastFilePath;
  String? currentTaskId;

  final ReceivePort _port = ReceivePort();

  @override
  void onInit() {
    super.onInit();
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback, step: 1);
  }

  @override
  void onClose() {
    _unbindBackgroundIsolate();
    super.onClose();
  }

  @pragma('vm:entry-point')
  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );

    if (!isSuccess) {
      IsolateNameServer.removePortNameMapping('downloader_send_port');
      IsolateNameServer.registerPortWithName(
        _port.sendPort,
        'downloader_send_port',
      );
    }

    _port.listen((dynamic data) {
      String id = data[0];
      int status = data[1];
      int prog = data[2];

      if (id == currentTaskId) {
        progress.value = prog / 100;

        if (status == 3) { // DownloadTaskStatus.complete = 3
          isDownloading.value = false;
          _showDownloadComplete();
        } else if (status == 4) { // DownloadTaskStatus.failed = 4
          isDownloading.value = false;
          progress.value = 0;
          Get.snackbar(
            'Error',
            'Download failed',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    });
  }

  @pragma('vm:entry-point')
  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  @pragma('vm:entry-point')
  Future<void> downloadFile(String url, String? fileName) async {
    try {
      if (url.isEmpty) {
        Get.snackbar(
          'Error',
          'Please enter a URL',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      isDownloading.value = true;
      progress.value = 0;

      // Request appropriate permissions
      bool hasPermission = await _requestPermissions();
      if (!hasPermission) {
        Get.snackbar(
          'Permission denied',
          'Cannot download file without permission',
          snackPosition: SnackPosition.BOTTOM,
        );
        isDownloading.value = false;
        return;
      }

      // Get directory
      Directory? dir;
      if (Platform.isAndroid) {
        // Try to use Download folder first
        dir = Directory('/storage/emulated/0/Download');
        if (!await dir.exists()) {
          dir = await getExternalStorageDirectory();
        }
      } else {
        dir = await getApplicationDocumentsDirectory();
      }

      final name = fileName ?? url.split('/').last.split('?').first;
      lastFilePath = '${dir!.path}/$name';

      print('Download URL: $url');
      print('Save Directory: ${dir.path}');
      print('File Name: $name');

      currentTaskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: dir.path,
        fileName: name,
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage: Platform.isAndroid,
      );

      print('Download started with taskId: $currentTaskId');

    } catch (e) {
      isDownloading.value = false;
      progress.value = 0;
      Get.snackbar(
        'Error',
        'Download failed: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Download error: $e');
    }
  }

  @pragma('vm:entry-point')
  Future<bool> _requestPermissions() async {
    if (Platform.isAndroid) {
      try {
        // Request storage permission
        var storageStatus = await Permission.storage.status;
        if (!storageStatus.isGranted) {
          storageStatus = await Permission.storage.request();
        }

        // For Android 11+, also request manageExternalStorage if needed
        if (!storageStatus.isGranted) {
          var manageStatus = await Permission.manageExternalStorage.status;
          if (!manageStatus.isGranted) {
            manageStatus = await Permission.manageExternalStorage.request();
          }
          return manageStatus.isGranted;
        }

        return storageStatus.isGranted;
      } catch (e) {
        print('Permission error: $e');
        // If permission request fails, try to continue anyway
        return true;
      }
    }
    return true;
  }

  @pragma('vm:entry-point')
  void _showDownloadComplete() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 48),
            SizedBox(height: 12),
            Text(
              'File Downloaded!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              lastFilePath ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                if (lastFilePath != null) {
                  OpenFile.open(lastFilePath!);
                }
                Get.back();
              },
              icon: Icon(Icons.open_in_new),
              label: Text('Open File'),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Close'),
            ),
          ],
        ),
      ),
      isDismissible: true,
    );
  }
}