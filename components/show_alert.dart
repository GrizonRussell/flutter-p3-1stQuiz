import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ShowAlert {
  void showAlert(String variant, String message) {
    if (variant.toLowerCase() == "success") {
      Get.snackbar(
        "Success",
        message,
        maxWidth: Get.width * 0.6,
        isDismissible: true,
        animationDuration: const Duration(milliseconds: 250),
        colorText: Colors.white,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(milliseconds: 1200),
      );
    } else if (variant.toLowerCase() == "info") {
      Get.snackbar(
        "Notice",
        maxWidth: Get.width * 0.6,
        message,
        colorText: Colors.white,
        backgroundColor: Colors.blue,
        animationDuration: const Duration(milliseconds: 250),
        snackPosition: SnackPosition.TOP,
        duration: const Duration(milliseconds: 1200),
        isDismissible: true,
      );
    } else {
      Get.snackbar(
        "Woops",
        maxWidth: Get.width * 0.6,
        message,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        animationDuration: const Duration(milliseconds: 250),
        snackPosition: SnackPosition.TOP,
        duration: const Duration(milliseconds: 1200),
        isDismissible: true,
      );
    }
  }
}