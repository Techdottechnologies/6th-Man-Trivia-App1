import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/text_widget.dart';

class UpdatedYourStatsScreen extends StatelessWidget {
  const UpdatedYourStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = [
      {"value": "20th", "label": "Global Ranking"},
      {"value": "8th", "label": "Friends Ranking"},
      {"value": "10", "label": "Highest Team Score"},
      {"value": "Warrior", "label": "Highest Score\nTeam Name"},
      {"value": "20th", "label": "Quiz Global Ranking"},
      {"value": "8th", "label": "Quiz Friends Ranking"},
      {"value": "8th", "label": "Crossword Global Ranking"},
      {"value": "8th", "label": "Crossword Friends Ranking"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back, color: Color(0xFFF86624)),
                  SizedBox(width: 5.w), // Placeholder for back button
                  text_widget(
                    "Your Stats",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  text_widget(
                    "Points System",
                    fontSize: 14.sp,
                    color: const Color(0xFFF86624),
                  ),
                ],
              ),
              SizedBox(height: 4.h),

              /// Profile Section
              CircleAvatar(
                radius: 28.sp,
                backgroundImage: const AssetImage(
                  "assets/images/profile.png",
                ), // Replace with your asset
              ),
              SizedBox(height: 1.5.h),
              text_widget(
                "Salman Ahmed",
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFF86624),
              ),
              text_widget("#349833", fontSize: 15.sp, color: Colors.grey),

              SizedBox(height: 3.h),

              /// XP Summary
              /// XP Summary - FIXED HEIGHT + WIDTH TO PREVENT OVERFLOW
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _xpCardFixed(
                    title: "2300",
                    subtitle: "Your XP",
                    bgColor: const Color(0xFFF86624),
                    textColor: Colors.white,
                  ),
                  SizedBox(width: 4.w),
                  _xpCardFixed(
                    title: "300",
                    subtitle: "Xp Required For\nRank Up",
                    bgColor: Colors.black,
                    textColor: Colors.white,
                  ),
                ],
              ),

              SizedBox(height: 3.h),

              /// Stats Grid
              GridView.builder(
                itemCount: stats.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.w,
                  mainAxisSpacing: 2.h,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (context, index) {
                  final item = stats[index];
                  final bool isWhite = (index % 4 == 0 || index % 4 == 3);
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    decoration: BoxDecoration(
                      color: isWhite ? Colors.white : const Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(20.sp),
                      border: Border.all(color: const Color(0x1AF86624)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        text_widget(
                          item["value"]!,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFF86624),
                        ),
                        SizedBox(height: 2.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: text_widget(
                            item["label"]!,
                            fontSize: 14.sp,
                            textAlign: TextAlign.center,
                            color: const Color(0xFF838383),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 4.h),

              /// Challenge A Friend Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: const Color(0xFFF86624),
                      width: 0.3.w,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: text_widget(
                    "Challenge A Friend",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFF86624),
                  ),
                ),
              ),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _xpCardFixed({
    required String title,
    required String subtitle,
    required Color bgColor,
    Color textColor = Colors.white,
  }) {
    return SizedBox(
      width: 42.w,
      height: 130,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text_widget(
              title,
              fontSize: 19.sp,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
            SizedBox(height: 1.h),
            text_widget(
              subtitle,
              textAlign: TextAlign.center,
              fontSize: 14.sp,
              color: textColor.withOpacity(0.9),
            ),
          ],
        ),
      ),
    );
  }
}
