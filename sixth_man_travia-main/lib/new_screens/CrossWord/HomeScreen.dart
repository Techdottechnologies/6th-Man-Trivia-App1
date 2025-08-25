import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/new_screens/CrossWord/PlayGameScreen.dart';
import 'package:sixth_man_travia/new_screens/CrossWord/PointsTableScreen.dart';
import 'package:sixth_man_travia/new_screens/CrossWord/admin_cross.dart';
import '../../widgets/text_widget.dart';

class CrosswordHomeScreen extends StatefulWidget {
  const CrosswordHomeScreen({super.key});

  @override
  State<CrosswordHomeScreen> createState() => _CrosswordHomeScreenState();
}

class _CrosswordHomeScreenState extends State<CrosswordHomeScreen> {
  DateTime selectedDate = DateTime.now();
  int selectedDayIndex = DateTime.now().weekday - 1;
  String activeTab = "Friends";

  final List<String> weekdays = ["M", "T", "W", "T", "F", "S", "S"];
  final List<Color> difficultyColors = [
    Colors.green,
    Colors.green,
    Colors.yellow,
    Colors.yellow,
    Colors.orange,
    Colors.orange,
    Colors.red,
  ];

  void _selectDay(int index) {
    setState(() {
      selectedDayIndex = index;
      selectedDate = DateTime.now().subtract(
        Duration(days: DateTime.now().weekday - 1 - index),
      );
    });
  }

  Widget _rankingBox(String rank, String label, bool isActive) {
    return Container(
      width: 42.w,
      padding: EdgeInsets.symmetric(vertical: 3.h),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF86624).withOpacity(0.5)),
      ),
      child: Column(
        children: [
          text_widget(
            rank,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFF86624),
          ),
          SizedBox(height: 1.h),
          text_widget(label, fontSize: 14.sp, color: const Color(0xFF838383)),
        ],
      ),
    );
  }

  Widget _tab(String title) {
    final isSelected = activeTab == title;
    return GestureDetector(
      onTap: () => setState(() => activeTab = title),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: text_widget(
          title,
          fontSize: 14.sp,
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
          radius: isBehind ? 20.sp : 24.sp,
          backgroundImage: AssetImage(imagePath),
        ),
        SizedBox(height: 0.8.h),
        text_widget(name, fontSize: 13.sp, color: Colors.white),
        SizedBox(height: 0.3.h),
        text_widget(
          score,
          fontSize: 12.sp,
          color: Colors.white.withOpacity(0.8),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 6.h),

              /// Header
              SizedBox(
                height: 40,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.arrow_back, color: Colors.orange),
                    ),
                    text_widget(
                      "Crossword Game",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E1E1E),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PointsTableScreen(),
                            ),
                          );
                        },
                        child: text_widget(
                          "Points System",
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFF86624),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 3.5.h),

              /// Date & Today
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 0.6.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.orange,
                            size: 18,
                          ),
                          SizedBox(width: 2.w),
                          text_widget(
                            DateFormat("dd MMM yy").format(selectedDate),
                            color: Colors.orange,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 0.6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          text_widget(
                            "Today",
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                          SizedBox(width: 2.w),
                          const Icon(Icons.keyboard_arrow_down, size: 18),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 3.h),

              /// Weekday Avatars
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (index) {
                  final isSelected = index == selectedDayIndex;
                  return GestureDetector(
                    onTap: () => _selectDay(index),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: isSelected
                              ? const Color(0xFFF86624)
                              : index == 1
                                  ? const Color(0xFFF86624).withOpacity(0.2)
                                  : Colors.white,
                          child: text_widget(
                            weekdays[index],
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 0.8.h),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: difficultyColors[index],
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),

              SizedBox(height: 3.h),

              /// Stack Card with Button and Background Text
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF484848), Color(0xFF181818)],
                          end: Alignment.topLeft,
                          begin: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Opacity(
                            opacity: 0.06,
                            child: Text(
                              "PLAY AGAIN!!!\nPLAY AGAIN!!!\nPLAY AGAIN!!!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 19.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          text_widget(
                            "Want to Play Again!",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -12,
                    left: 20.w,
                    right: 20.w,
                    child: Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const PlayGameScreen()),
                            );
                          },
                          child: Container(
                            height: 4.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF86624),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Center(
                              child: text_widget(
                                "Play Again",
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        InkWell(
                            onTap: () {
                              Get.to(const CrosswordAdminScreen());
                            },
                            child: CircleAvatar(
                              radius: 2.h,
                              backgroundColor: const Color(0xFFF86624),
                              child: Icon(Icons.add,
                                  size: 3.h, color: Colors.white),
                            )),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 1.h),

              /// Difficulty Legends
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.green,
                        ),
                        SizedBox(width: 1.w),
                        text_widget(
                          "Low Difficulty",
                          color: Colors.green,
                          fontSize: 13.sp,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        text_widget(
                          "High Difficulty",
                          color: Colors.red,
                          fontSize: 13.sp,
                        ),
                        SizedBox(width: 1.w),
                        const CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.red,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 3.h),

              /// Info Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _pillCard(
                    title: "Best Score:",
                    subtitle: "+150 XP",
                    isStreak: false,
                  ),
                  _pillCard(
                    title: "5 Days Streak",
                    subtitle: null,
                    isStreak: true,
                  ),
                ],
              ),

              SizedBox(height: 10.h),

              /// Ranking Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _rankingBox("20th", "Global Ranking", true),
                  _rankingBox("8th", "Friends Ranking", false),
                ],
              ),

              SizedBox(height: 3.h),

              /// Quiz Ranking with Tabs
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF86624),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text_widget(
                      "Quiz Ranking",
                      color: Colors.white,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _tab("Friends"),
                        const SizedBox(width: 12),
                        _tab("Global"),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _player(
                          "WILLIAM JACK",
                          "2250",
                          "assets/images/player-2.png",
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
                          "2020",
                          "assets/images/player-2.png",
                          true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 3.h),

              /// Share Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 1.4.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFF86624)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: text_widget(
                      "Share Your Score With Friends",
                      color: const Color(0xFFF86624),
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pillCard({
    required String title,
    required String? subtitle,
    required bool isStreak,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFF86624).withOpacity(0.5)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: subtitle == null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: text_widget(
                title,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFF86624),
              ),
            )
          : RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$title ",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  TextSpan(
                    text: subtitle,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFF86624),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
