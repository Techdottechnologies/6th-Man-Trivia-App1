import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/Controllers/authcontroller.dart';
import 'package:sixth_man_travia/screens/auth/change_password.dart';
import 'package:sixth_man_travia/screens/auth/forget_password.dart';
import 'package:sixth_man_travia/screens/auth/signup.dart';
import 'package:sixth_man_travia/widgets/_socialIcon.dart';
import 'package:sixth_man_travia/widgets/custom_nav.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = true;
  bool _obscurePassword = true;
  final AuthController loginController = Get.put(AuthController());

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
                /// Top Section
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                      ),
                      child: Image.asset(
                        'assets/images/welcome_back.png',
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
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 14.h,
                        ),
                      ),
                    ),
                  ],
                ),

                /// Form + Actions
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text_widget("Email Address",
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                          color: const Color(0xFF1E1E1E)),
                      SizedBox(height: 0.8.h),
                      customTextField(
                        hint: "Enter your email address",
                        controller: loginController.emailController,
                      ),
                      Obx(() => loginController.emailError.value.isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.only(top: 0.5.h, left: 2.w),
                              child: Text(
                                loginController.emailError.value,
                                style: TextStyle(
                                    color: Colors.red.shade900,
                                    fontSize: 13.sp),
                              ),
                            )
                          : const SizedBox()),

                      SizedBox(height: 1.6.h),
                      text_widget("Password",
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                          color: const Color(0xFF1E1E1E)),
                      SizedBox(height: 0.8.h),
                      customTextField(
                        hint: "Enter your password",
                        controller: loginController.passwordController,
                        obscureText: _obscurePassword,
                        hasSuffix: true,
                        suffixIcon: GestureDetector(
                          onTap: () => setState(
                              () => _obscurePassword = !_obscurePassword),
                          child: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color(0xFFFF6A00),
                            size: 16.sp,
                          ),
                        ),
                      ),
                      Obx(() => loginController.passwordError.value.isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.only(top: 0.5.h, left: 2.w),
                              child: Text(
                                loginController.passwordError.value,
                                style: TextStyle(
                                    color: Colors.red.shade900,
                                    fontSize: 13.sp),
                              ),
                            )
                          : const SizedBox()),

                      // ... Remember Me + Forgot Password

                      SizedBox(height: 1.6.h),

                      /// Remember Me & Forgot
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    setState(() => rememberMe = !rememberMe),
                                child: Icon(
                                  rememberMe
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color: const Color(0xFFFF6A00),
                                  size: 18.sp,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              text_widget(
                                "Remember me",
                                color: const Color(0xFF838383),
                                fontSize: 14.sp,
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(const ForgotPasswordScreen());
                            },
                            child: text_widget(
                              "Forgot Password?",
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF1E1E1E),
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 4.h),
                      GestureDetector(
                        onTap: () {
                          if (loginController.validateFields()) {
                            loginController.loginUser();
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
                              "Signin",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),

                      /// Signup Prompt
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            text_widget(
                              "Don’t have an account? ",
                              fontSize: 15.sp,
                              color: const Color(0xFF1E1E1E),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigate to signup
                              },
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(const SignupScreen());
                                },
                                child: text_widget(
                                  "Sign up",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFFF6A00),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 4.h),

                      /// Divider with text
                      Row(
                        children: [
                          const Expanded(child: Divider(thickness: 0.8)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: text_widget(
                              "Or continue with",
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ),
                          const Expanded(child: Divider(thickness: 0.8)),
                        ],
                      ),

                      SizedBox(height: 3.h),

                      /// Social Icons Row
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
