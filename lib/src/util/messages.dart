import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Messages {
  static Future<void> showMessage({required String title, required String content}) async {
    await Get.defaultDialog(
      titlePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      title: title,
      middleText: content,
      actions: [TextButton(onPressed: () => Get.back(), child: const Text('OK'))],
    );
  }

  static void showAutoCloseMessage({required String title, required String content, Duration? duration}) async {
    Get.defaultDialog(title: title, middleText: content);

    await Future.delayed(duration ?? const Duration(milliseconds: 1500));
    Get.back();
  }

  static void showSnackbar({required String title, required String message, Duration? duration}) async {
    Get.showSnackbar(GetSnackBar(title: title, message: message, duration: duration ?? const Duration(seconds: 4)));
  }
}
