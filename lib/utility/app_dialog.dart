// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nineproj/widgets/widget_image.dart';
import 'package:nineproj/widgets/widget_text.dart';
import 'package:nineproj/widgets/widget_text_button.dart';

class AppDialog {
  final BuildContext context;
  AppDialog({
    required this.context,
  });

  void normalDialog({
    Widget? iconWidget,
    required String title,
    Widget? contentWidget,
    Widget? firstButton,
    Widget? secondButton,
  }) {
    Get.dialog(
      AlertDialog(
        icon: iconWidget ??
            const WidgetImage(
              size: 120,
            ),
        title: WidgetText(data: title),
        content: contentWidget,
        actions: [
          firstButton ?? const SizedBox(),
          secondButton ?? const SizedBox(),
          WidgetTextButton(
            label: 'Cancel',
            pressFunc: () {
              Get.back();
            },
          )
        ],
        scrollable: true,
      ),
    );
  }
}
