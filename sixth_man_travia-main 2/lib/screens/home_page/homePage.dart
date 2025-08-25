import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/config.dart';
import 'package:sixth_man_travia/screens/home_page/TeamTriviaScreen.dart';
import 'package:sixth_man_travia/screens/quiz/QuizScreen.dart';
import 'package:sixth_man_travia/screens/quiz/add.dart';
import '../../widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String activeTab = 'Friends';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text_widget(
                        "Good Morning,",
                        fontSize: 17.sp,
                        color: const Color(0xFF1E1E1E),
                      ),
                      text_widget(
                        currentUser.name,
                        fontSize: 17.sp,
                        color: const Color(0xFFF86624),
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Get.to(const AddQuestionScreen());
                    },
                    child: CircleAvatar(
                      radius: 2.5.h,
                      backgroundColor: const Color(0xFFF86624),
                      child: Icon(Icons.add, size: 3.h, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  currentUser.profileImg == ""
                      ? CircleAvatar(
                          radius: 2.5.h,
                          backgroundColor: const Color(0xFFF86624),
                          child: Icon(Icons.person,
                              size: 3.h, color: Colors.white),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: FancyShimmerImage(
                            imageUrl: currentUser.profileImg,
                            width: 5.h,
                            height: 5.h,
                            boxFit: BoxFit.cover,
                            errorWidget:
                                Icon(Icons.error, size: 3.h, color: Colors.red),
                          ),
                        ),
                ],
              ),
              SizedBox(height: 3.h),

              /// TAKE QUIZ BLOCK
              InkWell(
                onTap: () {
                  Get.to( QuizScreen());
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
                          "Today Quiz is Available!",
                          fontSize: 17.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -2.6.h,
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
              SizedBox(height: 6.h),

              /// TEAM TRIVIA PROGRESS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  text_widget(
                    "Team Trivia Progress",
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E1E1E),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TeamTriviaScreen(),
                        ),
                      );
                    },
                    child: text_widget(
                      "See All",
                      fontSize: 14.sp,
                      color: const Color(0xFFF86624),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Wrap(
                spacing: 4.w,
                runSpacing: 2.h,
                children: [
                  _teamCard("LAKERS", ["8/10", "Not played", "Not played"]),
                  _teamCard("WARRIORS", [
                    "Not played",
                    "Not played",
                    "Not played",
                  ]),
                  _teamCard("CELTICS", ["8/10", "8/10", "8/10"]),
                  _teamCard("BULLS", ["8/10", "8/10", "Not played"]),
                ],
              ),
              SizedBox(height: 4.h),

              /// TOGGLE + PLAYERS
              /// TOGGLE + PLAYERS
              Container(
                width: 100.w,
                height: 23.h,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF86624),
                  borderRadius: BorderRadius.circular(22.sp),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.w,
                          vertical: 0.5.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.6),
                          ),
                          color: Colors.transparent,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _tab("Daily"),
                            _tab("Friends"),
                            _tab("Global"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
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

              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _teamCard(String teamName, List<String> scores) {
    return Container(
      width: 42.w,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: text_widget(
              teamName,
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFFF86624),
            ),
          ),
          Center(
            child: text_widget(
              "(Team)",
              fontSize: 14.sp,
              color: const Color(0xFF838383),
            ),
          ),
          SizedBox(height: 1.h),
          _scoreRow("Rookie:", scores[0]),
          _scoreRow("True Fan:", scores[1]),
          _scoreRow("Superfan:", scores[2]),
        ],
      ),
    );
  }

  Widget _scoreRow(String level, String value) {
    final isPlayed = value != "Not played";
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.5.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text_widget(
                level,
                fontSize: 12.sp,
                color: const Color(0xFF1E1E1E),
                fontWeight: FontWeight.w500,
              ),
              text_widget(
                value,
                fontSize: 12.sp,
                color: isPlayed
                    ? const Color(0xFFF86624)
                    : const Color(0xFF838383),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 0.3.h),
          height: 0.15.h,
          color: const Color(0xFFEDEDED),
        ),
      ],
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
