// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nineproj/widgets/widget_image.dart';

class AppSnackBar {
  final BuildContext context;
  final String title;
  final String message;
  AppSnackBar({
    required this.context,
    required this.title,
    required this.message,
  });

  void normalSnackBar() {
    Get.snackbar(
      title,
      message,
      icon: const WidgetImage(),
    );
  }

  void errorSnackBar() {
    Get.snackbar(
      title,
      message,
      icon: const WidgetImage(),
      backgroundColor: Theme.of(context).primaryColor,
      colorText: Colors.white,
    );
  }
}
