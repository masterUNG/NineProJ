import 'dart:io';

import 'package:get/get.dart';
import 'package:nineproj/models/product_model.dart';

class AppController extends GetxController {
  RxBool redEye = true.obs;
  RxList<File> files = <File>[].obs;
  RxList<ProductModel> productModels = <ProductModel>[].obs;
}
