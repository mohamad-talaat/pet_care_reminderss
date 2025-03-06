import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  static Future<bool?> showDeleteConfirmation({
    required String title,
    required String message,
  }) {
    return Get.defaultDialog(
      title: title,
      middleText: message,
      textConfirm: 'حذف',
      textCancel: 'إلغاء',
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.grey,
      buttonColor: Colors.red,
      onConfirm: () => Get.back(result: true),
      onCancel: () => Get.back(result: false),
    );
  }

  static void showSuccessSnackbar({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.7),
      colorText: Colors.white,
      margin: const EdgeInsets.all(8),
      borderRadius: 8,
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 500),
    );
  }
}
