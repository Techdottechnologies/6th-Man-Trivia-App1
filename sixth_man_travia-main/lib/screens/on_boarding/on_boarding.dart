import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/screens/auth/login.dart';
import '../../widgets/text_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      'image': 'assets/images/on_boarding-1.png',
      'title': 'From Rookie to Superfan — show the world what you’ve got.',
      'desc':
          'Prove it with 900 trivia questions across all 30 NBA teams. From rookies to superfans—this is your court.',
    },
    {
      'image': 'assets/images/on_boarding-1.png',
      'title': 'Master NBA knowledge & unlock hidden facts.',
      'desc': 'Answer deep-dive questions and discover legendary plays.',
    },
    {
      'image': 'assets/images/on_boarding-1.png',
      'title': 'Climb the leaderboard & flex your fan status.',
      'desc': 'Compete with friends and fans across the world.',
    },
  ];

  void nextPage() {
    if (currentPage < pages.length - 1) {
      setState(() => currentPage++);
    } else {
      Get.to(const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = pages[currentPage];

    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: Column(
        children: [
          /// Top image with bottom-left curve
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(100),
            ),
            child: Image.asset(
              page['image']!,
              height: 50.h,
              width: 100.w,
              fit: BoxFit.cover,
            ),
          ),

          /// Title
          Padding(
            padding: EdgeInsets.only(top: 4.h, left: 5.w, right: 5.w),
            child: text_widget(
              page['title']!,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E1E1E),
              textAlign: TextAlign.center,
              fontFamily: 'montserrat',
            ),
          ),

          /// Description
          Padding(
            padding: EdgeInsets.only(top: 1.8.h, left: 8.w, right: 8.w),
            child: text_widget(
              page['desc']!,
              fontSize: 15.sp,
              maxline: 2,
              color: const Color(0xFF838383),
              textAlign: TextAlign.center,
            ),
          ),

          /// Spacer
          SizedBox(height: 5.5.h),

          /// Next Button
          GestureDetector(
            onTap: nextPage,
            child: Container(
              width: 85.w,
              padding: EdgeInsets.symmetric(vertical: 1.2.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFF6A00),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: text_widget(
                  currentPage == pages.length - 1 ? "Start" : "Next",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          /// Indicator + Skip row
          Padding(
            padding: EdgeInsets.only(top: 4.h, bottom: 3.5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Left space to balance
                SizedBox(width: 15.w),

                /// Dots centered
                Row(
                  children: List.generate(
                    pages.length,
                    (i) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 1.2.w),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentPage == i
                            ? const Color(0xFFFF6A00)
                            : Colors.orange.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),

                /// Skip on right
                Padding(
                  padding: EdgeInsets.only(right: 6.w),
                  child: GestureDetector(
                    onTap: () {
                      setState(() => currentPage = pages.length - 1);
                    },
                    child: Row(
                      children: [
                        text_widget(
                          "Skip",
                          fontSize: 15.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
