import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nineproj/models/product_model.dart';
import 'package:nineproj/models/user_model.dart';
import 'package:nineproj/states/main_home.dart';
import 'package:nineproj/utility/app_controller.dart';
import 'package:nineproj/utility/app_snackbar.dart';
import 'package:path/path.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> editNameWhereId(
      {required ProductModel productModel, required String name}) async {
    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/ungNine/editNameWhereId.php?isAdd=true&id=${productModel.id}&name=$name';
    await dio.Dio().get(urlApi).then((value) {
      readAllProduct();
    });
  }

  Future<void> deleteProduct({required ProductModel productModel}) async {
    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/ungNine/deleteWhereId.php?isAdd=true&id=${productModel.id}';
    await dio.Dio().get(urlApi).then((value) {
      readAllProduct();
    });
  }

  Future<void> readAllProduct() async {
    if (appController.productModels.isNotEmpty) {
      appController.productModels.clear();
    }

    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/ungNine/getAllProduct.php';
    await dio.Dio().get(urlApi).then((value) {
      for (var element in json.decode(value.data)) {
        ProductModel productModel = ProductModel.fromMap(element);
        appController.productModels.add(productModel);
      }
    });
  }

  Future<void> processUploadAndInsertData(
      {required String name, required String detail}) async {
    String nameFile = basename(appController.files.last.path);
    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/ungNine/saveFile.php';

    print('nameFile ---> $nameFile');

    Map<String, dynamic> map = {};
    map['file'] = await dio.MultipartFile.fromFile(
        appController.files.last.path,
        filename: nameFile);
    dio.FormData data = dio.FormData.fromMap(map);
    await dio.Dio().post(urlApi, data: data).then((value) async {
      String urlImage =
          'https://www.androidthai.in.th/fluttertraining/ungNine/upload/$nameFile';
      print('urlImage ---> $urlImage');

      String urlInsert =
          'https://www.androidthai.in.th/fluttertraining/ungNine/insertProduct.php?isAdd=true&name=$name&detail=$detail&urlImage=$urlImage';

      await dio.Dio().get(urlInsert).then((value) {
        Get.back();
      });
    });
  }

  Future<void> processTakePhoto({required ImageSource imageSource}) async {
    var result = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (result != null) {
      File file = File(result.path);
      appController.files.add(file);
    }
  }

  Future<void> checkAuthen(
      {required String user,
      required String password,
      required BuildContext context}) async {
    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/ungNine/getUserWhereUser.php?isAdd=true&user=$user';

    await dio.Dio().get(urlApi).then((value) {
      print('## value --> $value');

      if (value.toString() == 'null') {
        AppSnackBar(
                context: context,
                title: 'User False',
                message: 'No $user in my Database')
            .errorSnackBar();
      } else {
        var result = json.decode(value.data);
        print('## result --> $result');

        for (var element in result) {
          UserModel userModel = UserModel.fromMap(element);
          if (password == userModel.password) {
            //Authen Success
            AppSnackBar(
                    context: context,
                    title: 'Authen Success',
                    message: 'Welcome ${userModel.name} to Application')
                .normalSnackBar();

            Get.offAll(const MainHome());
          } else {
            AppSnackBar(
                    context: context,
                    title: 'Password False',
                    message: 'Please Try Again Password False')
                .errorSnackBar();
          }
        }
      }
    });
  }
}
