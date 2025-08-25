import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/new_screens/quiz_question_screen.dart';
import '../../widgets/text_widget.dart';

class TeamOverviewScreen extends StatelessWidget {
  const TeamOverviewScreen({super.key});

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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              SizedBox(
                height: 50,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: text_widget(
                        "Team Name",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back, color: Colors.black),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: text_widget(
                          "Points System",
                          fontSize: 14.sp,
                          color: const Color(0xFFFF6A00),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _infoCard("20th", "Team Ranking", isDimmed: false),
                  _infoCard("08", "Team Average Score", isDimmed: true),
                ],
              ),
              SizedBox(height: 4.h),
              _quizRow("Rookie:", "Play Again", "8/10 (300XP)"),
              Divider(color: Colors.grey.shade300),
              _quizRow("True Fan:", null, "Not played"),
              Divider(color: Colors.grey.shade300),
              _quizRow("Superfan:", null, "Not played"),
              SizedBox(height: 5.h),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const QuizQuestionScreen(),
                    ),
                  );
                },
                child: _buildActionButton(
                  "Continue Team Quiz",
                  const Color(0xFFFF6A00),
                  Colors.white,
                ),
              ),
              SizedBox(height: 2.h),
              _gradientButton("Start from begining"),
              SizedBox(height: 2.h),
              _buildActionButton(
                "Challenge A Friend",
                Colors.transparent,
                const Color(0xFFF86624),
                border: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard(String value, String label, {bool isDimmed = false}) {
    return Container(
      width: 40.w,
      padding: EdgeInsets.symmetric(vertical: 3.h),
      decoration: BoxDecoration(
        color: isDimmed ? const Color(0xFFF9F9F9) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFFF6A00).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          text_widget(
            value,
            fontSize: 20.sp,
            color: const Color(0xFFFF6A00),
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 1.h),
          text_widget(
            label,
            fontSize: 15.sp,
            color: const Color(0xFF9E9E9E),
          ),
        ],
      ),
    );
  }

  Widget _quizRow(String title, String? buttonText, String result) {
    final bool isPlayed = buttonText != null;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.2.h),
      child: Row(
        children: [
          text_widget(
            title,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1E1E1E),
          ),
          const Spacer(),
          if (isPlayed)
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFFF6A00), width: 1.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                minimumSize: Size(0, 4.2.h),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: text_widget(
                buttonText!,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFFF6A00),
              ),
            ),
          if (isPlayed) SizedBox(width: 2.w),
          text_widget(
            result,
            fontSize: 15.5.sp,
            fontWeight: FontWeight.w500,
            color: isPlayed ? const Color(0xFFFF6A00) : const Color(0xFF9E9E9E),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    Color bgColor,
    Color textColor, {
    bool border = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 1.6.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(100),
          border: border ? Border.all(color: const Color(0xFFF86624)) : null,
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

  Widget _gradientButton(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 1.6.h),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          gradient: const LinearGradient(
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
