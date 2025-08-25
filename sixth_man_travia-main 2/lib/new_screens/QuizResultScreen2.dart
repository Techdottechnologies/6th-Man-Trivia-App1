import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_dash/flutter_dash.dart';
import '../../widgets/text_widget.dart';

class QuizResultScreen2 extends StatelessWidget {
  const QuizResultScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
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
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 1.h),

                /// Header
                SizedBox(
                  height: 40,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Icon(Icons.arrow_back, color: Colors.black),
                      ),
                      Center(
                        child: text_widget(
                          "Quiz Result",
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E1E1E),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: text_widget(
                            "Points System",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFF86624),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),

                /// XP Circle
                Container(
                  width: 42.w,
                  height: 42.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFF86624),
                      width: 0.3.w,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 2.h),
                      text_widget(
                        "500XP",
                        fontSize: 19.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFF86624),
                      ),
                      SizedBox(height: 2.h),
                      text_widget(
                        "Total XP Earned",
                        fontSize: 14.5.sp,
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 4.h),

                /// XP Summary
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _xpBox("1000 XP", "10/10  Correct Words", white: true),
                    _xpBox("+150 XP", "Finished Under 3 Min", white: false),
                  ],
                ),

                SizedBox(height: 3.h),

                /// Dotted Divider
                Dash(
                  direction: Axis.horizontal,
                  length: 90.w,
                  dashLength: 5,
                  dashColor: const Color(0xFFF86624),
                ),

                SizedBox(height: 3.h),

                /// Stats Grid
                Wrap(
                  spacing: 4.w,
                  runSpacing: 2.h,
                  children: [
                    _infoCard("10", "Best score"),
                    _infoCard("02:15", "Fastest time"),
                    _infoCard("05", "Number of attempts"),
                    _infoCard("25", "Overall team score"),
                    _infoCard("08", "Team Average Score"),
                    _infoCard("20th", "Team Ranking"),
                  ],
                ),

                SizedBox(height: 5.h),

                _buildActionButton(
                  "Next Difficulty Quiz",
                  const Color(0xFFF86624),
                  Colors.white,
                ),
                SizedBox(height: 2.h),
                _gradientButton("Back to Home"),
                SizedBox(height: 3.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _xpBox(String xp, String desc, {required bool white}) {
    return Container(
      width: 42.w,
      padding: EdgeInsets.symmetric(vertical: 3.3.h),
      decoration: BoxDecoration(
        color: white ? Colors.white : Colors.white70,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF86624).withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF86624).withOpacity(0.07),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          text_widget(
            xp,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFF86624),
          ),
          SizedBox(height: 2.h),
          text_widget(
            desc,
            fontSize: 14.5.sp,
            color: Colors.grey.shade600,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _infoCard(String value, String label) {
    return Container(
      width: 42.w,
      padding: EdgeInsets.symmetric(vertical: 3.3.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(45, 255, 255, 255),
            Color.fromARGB(139, 253, 248, 245),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFF86624).withOpacity(0.2),
          width: 0.3.w,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF86624).withOpacity(0.06),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          text_widget(
            value,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFF86624),
          ),
          SizedBox(height: 1.h),
          text_widget(
            label,
            fontSize: 14.5.sp,
            color: Colors.grey.shade600,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, Color bgColor, Color textColor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: text_widget(
            label,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }

  Widget _gradientButton(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: const LinearGradient(
            colors: [Color(0xFF484848), Color(0xFF181818)],
          ),
        ),
        child: Center(
          child: text_widget(
            title,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
