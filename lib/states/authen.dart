import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nineproj/utility/app_constant.dart';
import 'package:nineproj/utility/app_controller.dart';
import 'package:nineproj/utility/app_snackbar.dart';
import 'package:nineproj/widgets/widget_button.dart';
import 'package:nineproj/widgets/widget_form.dart';
import 'package:nineproj/widgets/widget_icon_button.dart';
import 'package:nineproj/widgets/widget_image.dart';
import 'package:nineproj/widgets/widget_text.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  AppController appController = Get.put(AppController());
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppConstant().radienBox(context: context),
        child: ListView(
          children: [
            headWidget(context),
            formUser(),
            formPassword(),
            buttonLogin(),
          ],
        ),
      ),
    );
  }

  Row buttonLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: 250,
          child: WidgetButton(
            label: 'Login',
            pressFunc: () {
              if ((userController.text.isEmpty) ||
                  (passwordController.text.isEmpty)) {
                AppSnackBar(
                        context: context,
                        title: 'Have Space ?',
                        message: 'Please Fill Every Blank')
                    .errorSnackBar();
              } else {}
            },
          ),
        ),
      ],
    );
  }

  Row formPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => WidgetForm(
            textEditingController: passwordController,
            obsecu: appController.redEye.value,
            hint: 'Password :',
            suffixWidget: WidgetIconButton(
              iconData: appController.redEye.value
                  ? Icons.visibility
                  : Icons.visibility_outlined,
              pressFunc: () {
                appController.redEye.value = !appController.redEye.value;
              },
            ),
          ),
        ),
      ],
    );
  }

  Row formUser() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WidgetForm(
          textEditingController: userController,
          hint: 'User :',
          suffixWidget: Icon(Icons.person_outline),
        ),
      ],
    );
  }

  Row headWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250,
          margin: const EdgeInsets.only(top: 100),
          child: Row(
            children: [
              const WidgetImage(
                size: 36,
              ),
              const SizedBox(
                width: 8,
              ),
              WidgetText(
                data: 'Nine ProJ',
                textStyle: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
        ),
      ],
    );
  }
}
