import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/text_widget.dart';

class FriendDetailsScreen extends StatelessWidget {
  const FriendDetailsScreen({super.key});

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
                    child:
                        const Icon(Icons.arrow_back, color: Color(0xFFF86624)),
                  ),
                  text_widget(
                    "Friend Name",
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
                    CircleAvatar(
                      radius: 28.sp,
                      backgroundImage: const AssetImage(
                        "assets/images/player-2.png",
                      ),
                    ),
                    SizedBox(height: 1.5.h),
                    text_widget(
                      "Salman Ahmed",
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
              _gradientButton("Remove from friends"),
              SizedBox(height: 2.h),
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
