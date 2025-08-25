import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/Controllers/authcontroller.dart';
import 'package:sixth_man_travia/screens/auth/login.dart';
import 'package:sixth_man_travia/widgets/custom_nav.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/_socialIcon.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      resizeToAvoidBottomInset: true,
      body: GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) => SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 2.h,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 100.h),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  /// Top Section
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
                          child: Image.asset('assets/images/logo.png',
                              height: 14.h),
                        ),
                      ),
                    ],
                  ),

                  /// Form
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Obx(() {
                                    final imagePath =
                                        controller.profileImageUrl.value;
                                    final isNetworkImage =
                                        imagePath.startsWith('http');

                                    return Container(
                                      width: 26.w,
                                      height: 26.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color(0xFFFF6A00),
                                          width: 2,
                                        ),
                                      ),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage: imagePath.isNotEmpty
                                            ? (isNetworkImage
                                                    ? NetworkImage(imagePath)
                                                    : FileImage(
                                                        File(imagePath)))
                                                as ImageProvider
                                            : null,
                                        child: imagePath.isEmpty
                                            ? Icon(Icons.person,
                                                color: Colors.grey, size: 24.sp)
                                            : null,
                                      ),
                                    );
                                  }),
                                  Positioned(
                                    bottom: 0,
                                    right: -4,
                                    child: GestureDetector(
                                      onTap: controller.pickProfileImage,
                                      child: Container(
                                        padding: EdgeInsets.all(1.1.h),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFFF6A00),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.camera_alt,
                                            size: 16, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 3.h),

                            /// Full Name
                            text_widget("Full Name",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF1E1E1E)),
                            SizedBox(height: 0.8.h),
                            customTextField(
                              hint: "Enter your name",
                              controller: controller.usernameController,
                            ),
                            if (controller.usernameError.value.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.only(top: 0.5.h, left: 2.w),
                                child: Text(
                                  controller.usernameError.value,
                                  style: TextStyle(
                                      color: Colors.red.shade900,
                                      fontSize: 13.sp),
                                ),
                              ),

                            SizedBox(height: 1.6.h),

                            /// Email
                            text_widget("Email Address",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF1E1E1E)),
                            SizedBox(height: 0.8.h),
                            customTextField(
                              hint: "Enter your email address",
                              controller: controller.emailController,
                            ),
                            if (controller.emailError.value.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.only(top: 0.5.h, left: 2.w),
                                child: Text(
                                  controller.emailError.value,
                                  style: TextStyle(
                                      color: Colors.red.shade900,
                                      fontSize: 13.sp),
                                ),
                              ),

                            SizedBox(height: 1.6.h),

                            /// Password
                            text_widget("Password",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF1E1E1E)),
                            SizedBox(height: 0.8.h),
                            customTextField(
                              hint: "Enter your password",
                              controller: controller.passwordController,
                              obscureText: controller.isPasswordHidden.value,
                              hasSuffix: true,
                              suffixIcon: GestureDetector(
                                onTap: controller.togglePasswordVisibility,
                                child: Icon(
                                  controller.isPasswordHidden.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: const Color(0xFFFF6A00),
                                  size: 16.sp,
                                ),
                              ),
                            ),
                            if (controller.passwordError.value.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.only(top: 0.5.h, left: 2.w),
                                child: Text(
                                  controller.passwordError.value,
                                  style: TextStyle(
                                      color: Colors.red.shade900,
                                      fontSize: 13.sp),
                                ),
                              ),

                            SizedBox(height: 1.6.h),

                            /// Confirm Password
                            text_widget("Confirm Password",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF1E1E1E)),
                            SizedBox(height: 0.8.h),
                            customTextField(
                              hint: "Confirm your password",
                              controller: controller.confirmPasswordController,
                              obscureText: controller.isPasswordHidden.value,
                              hasSuffix: true,
                              suffixIcon: GestureDetector(
                                onTap: controller.togglePasswordVisibility,
                                child: Icon(
                                  controller.isPasswordHidden.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: const Color(0xFFFF6A00),
                                  size: 16.sp,
                                ),
                              ),
                            ),
                            if (controller
                                .confirmPasswordError.value.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.only(top: 0.5.h, left: 2.w),
                                child: Text(
                                  controller.confirmPasswordError.value,
                                  style: TextStyle(
                                      color: Colors.red.shade900,
                                      fontSize: 13.sp),
                                ),
                              ),

                            SizedBox(height: 4.h),

                            /// Signup Button
                            GestureDetector(
                              onTap: () {
                                if (controller.validateFieldsSignUp()) {
                                  controller.signUp();
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
                                    "Signup",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 4.h),

                            /// Login Prompt
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  text_widget("Already have an account? ",
                                      fontSize: 15.sp,
                                      color: const Color(0xFF1E1E1E)),
                                  GestureDetector(
                                    onTap: () => Get.to(const LoginScreen()),
                                    child: text_widget(
                                      "Sign in",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFFFF6A00),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 4.h),

                            /// Divider
                            Row(
                              children: [
                                const Expanded(child: Divider(thickness: 0.8)),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.w),
                                  child: text_widget("Or continue with",
                                      fontSize: 14.sp, color: Colors.grey),
                                ),
                                const Expanded(child: Divider(thickness: 0.8)),
                              ],
                            ),

                            SizedBox(height: 3.h),

                            /// Social Icons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                socialIcon('assets/images/facebook.png'),
                                SizedBox(width: 4.w),
                                GestureDetector(
                                  onTap: () async {
                                    await Get.find<AuthController>()
                                        .signInWithGoogle();
                                  },
                                  child: socialIcon('assets/images/google.png'),
                                ),
                                SizedBox(width: 4.w),
                                socialIcon('assets/images/apple.png'),
                              ],
                            ),

                            SizedBox(height: 5.h),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
