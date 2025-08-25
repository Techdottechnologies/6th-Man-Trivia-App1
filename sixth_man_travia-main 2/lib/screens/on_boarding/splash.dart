import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/Controllers/authcontroller.dart';
import 'package:sixth_man_travia/config.dart';
import 'package:sixth_man_travia/screens/auth/verify.dart';
import 'package:sixth_man_travia/screens/on_boarding/on_boarding.dart';
import 'package:sixth_man_travia/widgets/custom_nav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      bool verify = await Get.find<AuthController>().checkEmailVarification();
      currentUser.id != ""
          ? verify
              ? Get.off(const CustomMainBottomNav(currentIndex: 0))
              : Get.off(const EmailVerify())
          : Get.off(const OnboardingScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Transform.scale(
            scale: 1,
            child: Image.asset(
              'assets/images/splash_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.4),
            child: Image.asset(
              'assets/images/logo.png',
              height: 22.h,
            ),
          ),
        ],
      ),
    );
  }
}
