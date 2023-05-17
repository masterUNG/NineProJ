import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nineproj/states/add_item.dart';
import 'package:nineproj/utility/app_controller.dart';
import 'package:nineproj/utility/app_dialog.dart';
import 'package:nineproj/utility/app_service.dart';
import 'package:nineproj/widgets/widget_button.dart';
import 'package:nineproj/widgets/widget_form.dart';
import 'package:nineproj/widgets/widget_icon_button.dart';
import 'package:nineproj/widgets/widget_image_network.dart';
import 'package:nineproj/widgets/widget_text.dart';
import 'package:nineproj/widgets/widget_text_button.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AppService().readAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print('## productModels --> ${appController.productModels.length}');
          return Scaffold(
            appBar: AppBar(
              title: const WidgetText(data: 'Main Home'),
            ),
            floatingActionButton: WidgetButton(
              label: 'Add Item',
              pressFunc: () {
                Get.to(const AddItem())!.then((value) {
                  print('## back');
                  appController.files.clear();
                  AppService().readAllProduct();
                });
              },
            ),
            body: appController.productModels.isEmpty
                ? const SizedBox()
                : ListView.builder(
                    itemCount: appController.productModels.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        AppDialog(context: context).normalDialog(
                          title: appController.productModels[index].name,
                          iconWidget: WidgetImageNetwork(
                            urlImage:
                                appController.productModels[index].urlImage,
                            size: 120,
                          ),
                          firstButton: WidgetTextButton(
                            label: 'Edit',
                            pressFunc: () {},
                          ),
                          secondButton: WidgetTextButton(
                            label: 'Delete',
                            pressFunc: () {
                              print(
                                  'deleta at id --> ${appController.productModels[index].id}');
                              AppService()
                                  .deleteProduct(
                                      productModel:
                                          appController.productModels[index])
                                  .then((value) {
                                Get.back();
                              });
                            },
                          ),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: WidgetImageNetwork(
                                  urlImage: appController
                                      .productModels[index].urlImage,
                                  size: 100,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      WidgetText(
                                        data: appController
                                            .productModels[index].name,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      WidgetIconButton(
                                        iconData: Icons.edit,
                                        pressFunc: () {
                                          AppDialog(context: context)
                                              .normalDialog(
                                                  title: appController
                                                      .productModels[index]
                                                      .name,
                                                  iconWidget:
                                                      WidgetImageNetwork(
                                                    urlImage: appController
                                                        .productModels[index]
                                                        .urlImage,
                                                    size: 120,
                                                  ),
                                                  contentWidget: WidgetForm(
                                                    textEditingController:
                                                        textEditingController,
                                                  ),
                                                  secondButton:
                                                      WidgetTextButton(
                                                    label: 'Edit',
                                                    pressFunc: () {
                                                      if (textEditingController
                                                          .text.isNotEmpty) {
                                                        print(
                                                            'new Name ---> ${textEditingController.text}');
                                                        AppService()
                                                            .editNameWhereId(
                                                                productModel:
                                                                    appController
                                                                            .productModels[
                                                                        index],
                                                                name:
                                                                    textEditingController
                                                                        .text)
                                                            .then((value) {
                                                          textEditingController
                                                              .text = '';
                                                          Get.back();
                                                        });
                                                      }
                                                    },
                                                  ));
                                        },
                                      )
                                    ],
                                  ),
                                  WidgetText(
                                      data: appController
                                          .productModels[index].detail),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        });
  }
}
