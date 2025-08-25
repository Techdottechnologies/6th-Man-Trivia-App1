import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/config.dart';
import 'package:sixth_man_travia/screens/auth/change_password.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    emailController.text = currentUser.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 100.h),
          child: IntrinsicHeight(
            child: Column(
              children: [
                /// Top Black Header
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                      ),
                      child: Image.asset(
                        'assets/images/forget_password.png',
                        height: 36.h,
                        width: 100.w,
                        fit: BoxFit.contain,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    Positioned(
                      top: 5.h,
                      left: 10,
                      // right: 0,
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFFFF6A00),
                        child: IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
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
                SizedBox(height: 6.h),

                /// Form Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Email Label
                      text_widget(
                        "Email Address",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1E1E1E),
                      ),
                      SizedBox(height: 0.8.h),

                      /// Email Field
                      customTextField(
                        hint: "Enter your email address",
                        controller: emailController,
                      ),

                      SizedBox(height: 14.h),

                      /// Send Button
                      GestureDetector(
                        onTap: () async {
                          final email = emailController.text.trim();

                          if (email.isEmpty || !email.contains('@')) {
                            EasyLoading.showInfo(
                                "Please enter a valid email".tr);
                            return;
                          }

                          try {
                            EasyLoading.show(
                                status: "Sending reset link...".tr);
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: email);
                            EasyLoading.dismiss();
                            EasyLoading.showSuccess(
                                "Password reset email sent!".tr);
                            Navigator.pop(context);
                          } catch (e) {
                            EasyLoading.dismiss();
                            EasyLoading.showInfo(
                                "Failed to send email. Check email or try again."
                                    .tr);
                            print("Password reset error: $e");
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
                              "Send",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 5.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
