import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/screens/quiz/QuizScreen.dart';
import '../../widgets/text_widget.dart';

class QuizHomeScreen extends StatefulWidget {
  const QuizHomeScreen({super.key});

  @override
  State<QuizHomeScreen> createState() => _QuizHomeScreenState();
}

class _QuizHomeScreenState extends State<QuizHomeScreen> {
  String activeTab = "Friends";
  bool quizAvailable =
      true; // You can toggle this value based on time or condition

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back, color: Colors.black),
                  text_widget(
                    "Daily Quiz",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  const Icon(Icons.arrow_back, color: Colors.transparent),
                ],
              ),
              SizedBox(height: 4.h),

              /// Today Quiz Banner with CTA
              InkWell(
                onTap: () {
                  Get.to(const QuizScreen());
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF484848), Color(0xFF181818)],
                        ),
                        borderRadius: BorderRadius.circular(22.sp),
                      ),
                      child: Center(
                        child: text_widget(
                          quizAvailable
                              ? "Today Quiz is Available!"
                              : "Next Quiz Coming",
                          fontSize: 17.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (quizAvailable)
                      Positioned(
                        bottom: -2.h,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 0.6.h,
                              horizontal: 8.w,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF6A00),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: text_widget(
                              "Take Quiz",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const Spacer(),

              /// Quiz Ranking Box
              Container(
                width: 100.w,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF86624),
                  borderRadius: BorderRadius.circular(22.sp),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        text_widget(
                          "Quiz Ranking",
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 1.w,
                            vertical: 0.5.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [_tab("Friends"), _tab("Global")],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),

                    /// Players Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _player(
                          "WILLIAM JACK",
                          "2250",
                          "assets/images/player-1.png",
                          true,
                        ),
                        _player(
                          "SALMAN SALEEM",
                          "2300",
                          "assets/images/player-2.png",
                          false,
                        ),
                        _player(
                          "JOHN DOE",
                          "2200",
                          "assets/images/player-3.png",
                          true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tab(String title) {
    final isSelected = activeTab == title;
    return InkWell(
      onTap: () => setState(() => activeTab = title),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0.6.h, horizontal: 5.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: text_widget(
          title,
          fontSize: 13.5.sp,
          fontWeight: FontWeight.w600,
          color: isSelected ? const Color(0xFFF86624) : Colors.white,
        ),
      ),
    );
  }

  Widget _player(String name, String score, String imagePath, bool isBehind) {
    return Column(
      children: [
        CircleAvatar(
          radius: isBehind ? 19.sp : 23.sp,
          backgroundImage: AssetImage(imagePath),
        ),
        SizedBox(height: 0.8.h),
        text_widget(name, fontSize: 13.sp, color: Colors.white),
        SizedBox(height: 0.2.h),
        text_widget(
          score,
          fontSize: 12.5.sp,
          color: Colors.white.withOpacity(0.7),
        ),
      ],
    );
  }
}
