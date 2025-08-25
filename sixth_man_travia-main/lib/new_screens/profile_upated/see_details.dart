import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/text_widget.dart';

class ChallengeDetailScreen extends StatelessWidget {
  const ChallengeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              SizedBox(height: 2.h),

              /// Back + Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFFFF6A00),
                    ),
                  ),
                  text_widget(
                    "Details",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 24),
                ],
              ),

              SizedBox(height: 3.h),

              /// Profile Image + Name + ID
              CircleAvatar(
                radius: 7.h,
                backgroundImage: const AssetImage("assets/images/player-2.png"),
              ),
              SizedBox(height: 2.h),
              text_widget(
                "Salman Ahmed",
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFFF6A00),
              ),
              text_widget(
                "#349833",
                fontSize: 15.sp,
                color: Colors.grey.shade700,
              ),

              SizedBox(height: 4.h),

              /// XP Circle
              Container(
                width: 35.w,
                height: 35.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFFF6A00),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    text_widget(
                      "500XP",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFF6A00),
                    ),
                    SizedBox(height: 1.h),
                    text_widget(
                      "Total XP Earned",
                      fontSize: 14.sp,
                      color: Colors.grey.shade800,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 4.h),

              /// XP Stats Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _xpBox("1000 XP", "10/10  Correct Words", white: true),
                  _xpBox("+150 XP", "Finished Under 3 Min", white: false),
                ],
              ),

              SizedBox(height: 5.h),

              /// Take Quiz Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 1.6.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6A00),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    alignment: Alignment.center,
                    child: text_widget(
                      "Take Quiz",
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _xpBox(String xp, String desc, {required bool white}) {
    return Container(
      width: 42.w,
      padding: EdgeInsets.symmetric(vertical: 3.h),
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
}
