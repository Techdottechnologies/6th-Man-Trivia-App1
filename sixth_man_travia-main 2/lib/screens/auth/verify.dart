import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/Controllers/authcontroller.dart';
import 'package:sixth_man_travia/Controllers/drawer_Controller.dart';
import 'package:sixth_man_travia/config.dart';
import 'package:sixth_man_travia/screens/auth/login.dart';
import 'package:sixth_man_travia/services/auth.dart';
import 'package:sixth_man_travia/widgets/custom_nav.dart';
import 'package:sixth_man_travia/widgets/text_widget.dart';

class EmailVerify extends StatelessWidget {
  const EmailVerify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 100.h),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                      ),
                      child: Image.asset(
                        'assets/images/create_acc.png',
                        height: 36.h,
                        width: 100.w,
                        fit: BoxFit.contain,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    Positioned(
                      top: 12.h,
                      left: 0,
                      right: 0,
                      child: Center(
                        child:
                            Image.asset('assets/images/logo.png', height: 14.h),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 55.h,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 12),
                      child: Column(children: [
                        // const Spacer(flex: 1),
                        // Center(
                        //   child: Image.asset(
                        //     'assets/icons/logo.png',
                        //     color: const Color(0xff1379B2),
                        //     width: 20.w,
                        //     fit: BoxFit.contain,
                        //   ),
                        // ),

                        const Spacer(flex: 1),
                        InkWell(
                          onTap: () {
                            log(currentUser.id);
                          },
                          child: Text('Verify Your Email'.tr,
                              style: GoogleFonts.montserrat(
                                  fontSize: 20.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center),
                        ),
                        SizedBox(height: 2.h),
                        // Image.asset('assets/images/verf.png', height: 19.h),
                        SizedBox(height: 5.h),
                        Text(
                            'Welcome to 6th Man Trivia.\nPlease check the inbox of : '
                                .tr,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w300)),
                        SizedBox(height: 0.3.h),
                        Text(currentUser.email,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 15.3.sp,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 1.h),
                        Text('No email? Check the spam folder'.tr,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 14.5.sp,
                                fontWeight: FontWeight.w300)),
                        SizedBox(height: 13.h),
                        GestureDetector(
                          onTap: () async {
                            EasyLoading.show();
                            bool verify = await Get.find<AuthController>()
                                .checkEmailVarification();
                            EasyLoading.dismiss();
                            if (verify) {
                              Get.offAll(
                                  const CustomMainBottomNav(currentIndex: 0));
                            } else {
                              EasyLoading.showInfo("Please Verify First".tr);
                            }
                          },
                          child: Container(
                            width: 100.w,
                            padding: EdgeInsets.symmetric(vertical: 1.4.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF6A00),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: text_widget(
                                "Verify",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 2.h),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  // Get.find<DrawerControllerX>().closeDrawer();
                                  await Get.find<AuthController>().logout();
                                  Get.off(const LoginScreen());
                                },
                                child: Text('Logout'.tr,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.red,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        decorationThickness: 2)),
                              ),
                              SizedBox(width: 4.w),
                              SizedBox(
                                  height: 2.h,
                                  child: const VerticalDivider(
                                      color: Color(0xFFFF6A00), thickness: 2)),
                              SizedBox(width: 4.w),
                              InkWell(
                                  onTap: () {
                                    Get.find<AuthController>()
                                        .sendEmailVarification();
                                    EasyLoading.showSuccess(
                                        "Resent email successfully");
                                  },
                                  child: Text('Resend',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          color: const Color(0xFFFF6A00),
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          // decorationColor: Color(0xffFE9345),
                                          decorationThickness: 2)))
                            ]),
                        const Spacer(),
                      ])),
                ),
              ],
            )));
  }
}
