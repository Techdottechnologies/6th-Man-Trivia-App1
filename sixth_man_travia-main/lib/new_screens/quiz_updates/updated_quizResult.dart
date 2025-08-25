import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/text_widget.dart';

class UpatedQuizResultScreen extends StatelessWidget {
  const UpatedQuizResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFE7E7E7),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Header
                SizedBox(
                  height: 40,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.arrow_back, color: Colors.orange),
                      ),
                      text_widget(
                        "Quiz Result",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E1E1E),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: text_widget(
                          "Points System",
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFF86624),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 5.h),

                /// Score Circle
                Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFFF86624), width: 0.4.w),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      text_widget(
                        "500XP",
                        fontSize: 20.5.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFF86624),
                      ),
                      SizedBox(height: 1.h),
                      text_widget(
                        "Total XP Earned",
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF838383),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 5.h),

                /// XP Boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _xpBox("1000 XP", "10/10 Correct Words", isGrey: false),
                    _xpBox("+150 XP", "Finished Under 3 Min", isGrey: true),
                  ],
                ),

                SizedBox(height: 3.5.h),

                /// Ranking Boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _infoCard("20th", "Global Ranking", isGrey: false),
                    _infoCard("8th", "Friends Ranking", isGrey: true),
                  ],
                ),

                SizedBox(height: 5.h),

                /// Buttons
                _gradientButton("Back to Home"),
                SizedBox(height: 2.h),
                _outlinedButton("Challenge A Friend"),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _xpBox(String xp, String desc, {bool isGrey = false}) {
    return Container(
      width: 42.w,
      padding: EdgeInsets.symmetric(vertical: 3.5.h),
      decoration: BoxDecoration(
        color: isGrey ? const Color(0xFFF8F8F8) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFF86624).withOpacity(0.25),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF86624).withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          text_widget(
            xp,
            fontSize: 17.5.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFF86624),
          ),
          SizedBox(height: 0.8.h),
          text_widget(
            desc,
            fontSize: 14.5.sp,
            color: const Color(0xFF838383),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _infoCard(String value, String label, {bool isGrey = false}) {
    return Container(
      width: 42.w,
      padding: EdgeInsets.symmetric(vertical: 3.5.h),
      decoration: BoxDecoration(
        color: isGrey ? const Color(0xFFF8F8F8) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFF86624).withOpacity(0.25),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF86624).withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          text_widget(
            value,
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFF86624),
          ),
          SizedBox(height: 0.8.h),
          text_widget(
            label,
            fontSize: 14.5.sp,
            color: const Color(0xFF838383),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _gradientButton(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 1.4.h),
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

  Widget _outlinedButton(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 1.3.h),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFF86624), width: 1.5),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: text_widget(
            title,
            fontSize: 15.5.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFF86624),
          ),
        ),
      ),
    );
  }
}
