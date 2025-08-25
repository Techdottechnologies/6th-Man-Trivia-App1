import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/config.dart';
import 'package:sixth_man_travia/screens/on_boarding/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ REQUIRED
  await onInit();
  runApp(const SixthManTraviaApp());
}

class SixthManTraviaApp extends StatelessWidget {
  const SixthManTraviaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        );
      },
    );
  }
}
