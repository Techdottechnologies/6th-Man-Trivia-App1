import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/custom_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final emailController = TextEditingController();

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
                        onTap: () {},
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
