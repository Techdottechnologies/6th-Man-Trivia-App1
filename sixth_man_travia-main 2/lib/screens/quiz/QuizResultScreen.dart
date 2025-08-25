////// stillll to edit from figma //////
library;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/widgets/custom_nav.dart';
import '../../widgets/text_widget.dart';

class QuizResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const QuizResultScreen({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Header
              const Row(
                children: [
                  Icon(Icons.arrow_back),
                  Spacer(),
                  Text(
                    "Quiz Result",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Color(0xFF1E1E1E),
                    ),
                  ),
                  Spacer(),
                  SizedBox(width: 24),
                ],
              ),

              SizedBox(height: 5.h),

              /// Score Circle
              Container(
                width: 30.w,
                height: 30.w,
                padding: EdgeInsets.symmetric(vertical: 2.h),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFF86624), width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Score row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        text_widget(
                          score.toString().padLeft(2, '0'),
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFF86624),
                        ),
                        SizedBox(width: 1.w),
                        Padding(
                          padding: EdgeInsets.only(bottom: 0.5.h),
                          child: text_widget(
                            "/$total",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFF86624),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),

                    /// Your Score text
                    text_widget(
                      "Your Score",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF838383),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 6.h),

              /// Ranking & Average Score Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _box("20th", "Team Ranking", isWhite: true),
                  _box("08", "Team Average Score", isWhite: false),
                ],
              ),
              SizedBox(height: 5.h),

              /// Buttons
              _button(
                "Next Difficulty Quiz",
                const Color(0xFFF86624),
                Colors.white,
              ),
              SizedBox(height: 2.h),

              InkWell(
                  onTap: () {
                    Get.offAll(const CustomMainBottomNav(
                      currentIndex: 0,
                    ));
                  },
                  child: _gradientButton("Back to Home")),
            ],
          ),
        ),
      ),
    );
  }

  /// Box Card with conditional background
  Widget _box(String value, String label, {required bool isWhite}) {
    return Container(
      width: 40.w,
      height: 14.h,
      padding: EdgeInsets.symmetric(vertical: 3.h),
      decoration: BoxDecoration(
        color: isWhite ? Colors.white : const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(18.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: const Color(0xFFF3F3F3), width: 1),
      ),
      child: Column(
        children: [
          text_widget(
            value,
            fontSize: 19.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFF86624),
          ),
          SizedBox(height: 0.5.h),
          text_widget(label, fontSize: 14.sp, color: const Color(0xFF838383)),
        ],
      ),
    );
  }

  /// Solid Orange Button
  Widget _button(String title, Color bg, Color textColor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 1.6.h),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: text_widget(
            title,
            fontSize: 15.5.sp,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }

  /// Gradient Black Button (same as Quiz screen)
  Widget _gradientButton(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 1.6.h),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF484848), Color(0xFF181818)],
          ),
        ),
        child: Center(
          child: text_widget(
            title,
            fontSize: 15.5.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
