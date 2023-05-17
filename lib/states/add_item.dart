import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nineproj/utility/app_controller.dart';
import 'package:nineproj/utility/app_dialog.dart';
import 'package:nineproj/utility/app_service.dart';
import 'package:nineproj/utility/app_snackbar.dart';
import 'package:nineproj/widgets/widget_button.dart';
import 'package:nineproj/widgets/widget_form.dart';
import 'package:nineproj/widgets/widget_image.dart';
import 'package:nineproj/widgets/widget_image_file.dart';
import 'package:nineproj/widgets/widget_text.dart';
import 'package:nineproj/widgets/widget_text_button.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController detailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const WidgetText(data: 'Add New Item'),
      ),
      body: ListView(
        children: [
          Obx(() {
            return appController.files.isEmpty
                ? WidgetImage(
                    path: 'images/image.png',
                    size: 200,
                    tapFunc: () {
                      print('## You tap');
                      AppDialog(context: context).normalDialog(
                          title: 'Take Photo',
                          iconWidget: const WidgetImage(
                            path: 'images/image.png',
                            size: 120,
                          ),
                          firstButton: WidgetTextButton(
                            label: 'Camera',
                            pressFunc: () {
                              Get.back();
                              AppService().processTakePhoto(
                                  imageSource: ImageSource.camera);
                            },
                          ),
                          secondButton: WidgetTextButton(
                            label: 'Gallery',
                            pressFunc: () {
                              Get.back();
                              AppService().processTakePhoto(
                                  imageSource: ImageSource.gallery);
                            },
                          ));
                    },
                  )
                : WidgetImageFile(
                    file: appController.files.last,
                    size: 200,
                  );
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetForm(
                labelWidget: const WidgetText(data: 'Name :'),
                textEditingController: nameController,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetForm(
                labelWidget: const WidgetText(data: 'Detail :'),
                textEditingController: detailController,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetButton(
                label: 'Add New Item',
                pressFunc: () {
                  if (appController.files.isEmpty) {
                    AppSnackBar(
                            context: context,
                            title: 'No Image',
                            message: '{Please Take Photo}')
                        .errorSnackBar();
                  } else if ((nameController.text.isEmpty) ||
                      (detailController.text.isEmpty)) {
                    AppSnackBar(
                            context: context,
                            title: 'Have Space',
                            message: 'Fill Every Blank')
                        .errorSnackBar();
                  } else {
                    AppService().processUploadAndInsertData(name: nameController.text, detail: detailController.text);
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
