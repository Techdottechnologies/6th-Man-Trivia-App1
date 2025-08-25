import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/text_widget.dart';

class ProfilePictureScreen extends StatelessWidget {
  const ProfilePictureScreen({super.key});

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
                        'assets/images/profile_pic.png',
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

                SizedBox(height: 4.h),

                /// Circular Image Picker
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 18.h,
                      width: 18.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFFF6A00),
                          width: 1.5,
                        ),
                        color: Colors.white,
                      ),
                      child: ClipOval(
                        child: Icon(
                          Icons.person,
                          size: 10.h,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),

                    /// Camera Icon
                    Positioned(
                      bottom: 2.h,
                      right: 1.w,
                      child: Container(
                        height: 4.h,
                        width: 4.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFF6A00),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),

                /// Next Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: GestureDetector(
                    onTap: () {
                      // Handle next
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
                          "Next",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
