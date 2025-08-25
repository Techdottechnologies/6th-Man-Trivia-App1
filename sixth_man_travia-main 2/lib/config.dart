import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sixth_man_travia/Controllers/authcontroller.dart';
import 'package:sixth_man_travia/model/user.dart';
import 'package:sixth_man_travia/services/api.dart';
import 'package:sixth_man_travia/services/auth.dart';
import 'package:sixth_man_travia/services/firestore.dart';


UserModel currentUser = UserModel();

Future<void> onInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.circle;
  EasyLoading.instance.toastPosition = EasyLoadingToastPosition.top;
  EasyLoading.instance.dismissOnTap = false;
  EasyLoading.instance.displayDuration = const Duration(seconds: 3);
  Get.put(AuthServices());
  Get.put(FirestoreServices());
  Get.put(AuthController());
  FirestoreApi.init();
  await Get.find<AuthServices>().checkUser();
  if (currentUser.id != "") {
    currentUser =
        (await Get.find<FirestoreServices>().getUser(currentUser.id)) ??
            UserModel();
    print(currentUser.id); //debug
  }
}
