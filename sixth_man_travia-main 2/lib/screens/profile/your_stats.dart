import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/config.dart';
import '../../widgets/text_widget.dart';

class YourStats extends StatelessWidget {
  const YourStats({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> stats = [
      {"value": "20th", "label": "Global Ranking"},
      {"value": "8th", "label": "Friends Ranking"},
      {"value": "10", "label": "Highest Team Score"},
      {"value": "Warrior", "label": "Highest Score\nTeam Name"},
      {"value": "20th", "label": "Quiz Global Score"},
      {"value": "8th", "label": "Quiz Friends Ranking"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFFF86624),
                    ),
                  ),
                  text_widget(
                    "Your Stats",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1E1E1E),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
              SizedBox(height: 2.h),

              /// Profile Section
              Center(
                child: Column(
                  children: [
                    currentUser.profileImg == ""
                        ? CircleAvatar(
                            radius: 5.h,
                            backgroundColor: const Color(0xFFF86624),
                            child: Icon(Icons.person,
                                size: 4.h, color: Colors.white),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: FancyShimmerImage(
                              imageUrl: currentUser.profileImg,
                              width: 10.h,
                              height: 10.h,
                              boxFit: BoxFit.cover,
                              errorWidget: Icon(Icons.error,
                                  size: 3.h, color: Colors.red),
                            ),
                          ),
                    SizedBox(height: 1.5.h),
                    text_widget(
                      currentUser.name,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFF86624),
                    ),
                    SizedBox(height: 0.5.h),
                    text_widget(
                      "#549833",
                      fontSize: 14.sp,
                      color: const Color(0xFF838383),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),

              /// Stats Grid with true alternating colors
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
                  final bool isWhite = (index % 4 == 0 ||
                      index % 4 == 3); // 0,3 = white; 1,2 = grey
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

              _buildActionButton(
                "Challenge A Friend",
                Colors.white,
                const Color(0xFFF86624),
                border: true,
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
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
}
