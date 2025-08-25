import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/text_widget.dart';

class ChallengeFriendScreen extends StatefulWidget {
  const ChallengeFriendScreen({super.key});

  @override
  State<ChallengeFriendScreen> createState() => _ChallengeFriendScreenState();
}

class _ChallengeFriendScreenState extends State<ChallengeFriendScreen> {
  String? selectedTeam;
  String? selectedDifficulty;

  final List<String> teams = ["Lakers", "Warriors", "Bulls", "Celtics"];
  final List<String> difficulties = ["Rookie", "True Fan", "Superfan"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFFFFF), Color(0xFFE7E7E7)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Row(
                  children: [
                    const Icon(Icons.arrow_back, color: Color(0xFFF86624)),
                    SizedBox(width: 3.w),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0.w),
                      child: text_widget(
                        "Challenge Friend",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1E1E1E),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),

                /// Title
                Center(
                  child: text_widget(
                    "Add Info",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFF86624),
                  ),
                ),
                SizedBox(height: 4.h),

                /// Team Dropdown
                text_widget(
                  "Team",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 1.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: const Color(0xFFF86624),
                      width: 1.5,
                    ),
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedTeam,
                      hint: text_widget(
                        "Select Team",
                        fontSize: 15.sp,
                        color: Colors.grey,
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                      ),
                      isExpanded: true,
                      items: teams.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: text_widget(
                            value,
                            fontSize: 15.sp,
                            color: Colors.black,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedTeam = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 3.h),

                /// Difficulty Dropdown
                text_widget(
                  "Difficulty",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 1.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedDifficulty,
                      hint: text_widget(
                        "Select Difficulty",
                        fontSize: 15.sp,
                        color: Colors.grey,
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                      ),
                      isExpanded: true,
                      items: difficulties.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: text_widget(
                            value,
                            fontSize: 15.sp,
                            color: Colors.black,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDifficulty = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 3.h),

                /// Note Input
                text_widget(
                  "Note",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 1.h),
                TextField(
                  maxLines: 6,
                  style: TextStyle(fontSize: 15.sp, color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Any thing you want to say ….",
                    hintStyle: TextStyle(fontSize: 15.sp, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 2.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 6.h),

                /// NEXT Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 1.6.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF86624),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: text_widget(
                        "Next",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
