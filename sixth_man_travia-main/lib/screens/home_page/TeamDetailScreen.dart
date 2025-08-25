import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/screens/quiz/QuizScreen.dart';
import 'package:sixth_man_travia/screens/quiz/challange_friend.dart';
import '../../widgets/text_widget.dart';

class TeamDetailScreen extends StatelessWidget {
  const TeamDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back, color: Colors.black),
                  text_widget(
                    "Team Name",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E1E1E),
                  ),
                  const SizedBox(width: 24), // Placeholder for alignment
                ],
              ),
              SizedBox(height: 3.h),

              /// Rank + Average Score
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _boxInfo("20th", "Team Ranking"),
                  _boxInfo("08", "Team Average Score"),
                ],
              ),
              SizedBox(height: 4.h),

              /// Quiz Levels
              _quizRow("Rookie:", "8/10", showPlayAgain: true),
              _dividerLine(),
              _quizRow("True Fan:", "Not played"),
              _dividerLine(),
              _quizRow("Superfan:", "Not played"),
              SizedBox(height: 5.h),

              /// Buttons
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QuizScreen()),
                    );
                  },
                  child: _solidButton("Continue Team Quiz",
                      const Color(0xFFF86624), Colors.white)),
              SizedBox(height: 2.h),
              _solidButton(
                  "Start from begining", const Color(0xFF1E1E1E), Colors.white),
              SizedBox(height: 2.h),
              InkWell(
                onTap: () {
                  Get.to(const ChallengeFriendScreen());
                },
                child: _outlineButton("Challenge A Friend"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _boxInfo(String value, String label) {
    return Container(
      width: 42.w,
      padding: EdgeInsets.symmetric(vertical: 3.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.sp),
        border: Border.all(color: const Color(0x1AF86624)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          text_widget(value,
              fontSize: 22.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFFE86624)),
          SizedBox(height: 1.h),
          text_widget(label, fontSize: 14.sp, color: const Color(0xFFB9B9B9)),
        ],
      ),
    );
  }

  Widget _quizRow(String title, String score, {bool showPlayAgain = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text_widget(title,
              fontSize: 15.sp,
              color: const Color(0xFF1E1E1E),
              fontWeight: FontWeight.w500),
          if (showPlayAgain)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.6.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: const Color(0xFFF86624)),
              ),
              child: text_widget("Play Again",
                  fontSize: 13.sp, color: const Color(0xFFF86624)),
            ),
          if (showPlayAgain) SizedBox(width: 3.w),
          text_widget(
            score,
            fontSize: 15.sp,
            color: score == "Not played"
                ? const Color(0xFF838383)
                : const Color(0xFFF86624),
          ),
        ],
      ),
    );
  }

  Widget _dividerLine() {
    return Container(
      margin: EdgeInsets.only(top: 0.5.h),
      height: 0.12.h,
      color: const Color(0xFFEDEDED),
    );
  }

  Widget _solidButton(String label, Color bg, Color textColor) {
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
            label,
            fontSize: 15.5.sp,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }

  Widget _outlineButton(String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 1.6.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: const Color(0xFFF86624)),
        ),
        child: Center(
          child: text_widget(
            label,
            fontSize: 15.5.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFF86624),
          ),
        ),
      ),
    );
  }
}
