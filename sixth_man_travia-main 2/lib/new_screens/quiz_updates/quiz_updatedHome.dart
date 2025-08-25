import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/widgets/text_widget.dart';

class UpatedQuizHomeScreen extends StatefulWidget {
  const UpatedQuizHomeScreen({super.key});

  @override
  State<UpatedQuizHomeScreen> createState() => _UpatedQuizHomeScreenState();
}

class _UpatedQuizHomeScreenState extends State<UpatedQuizHomeScreen> {
  String activeTab = "Friends";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFFFFF), Color(0xFFE7E7E7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              children: [
                SizedBox(height: 2.h),

                /// Title Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.arrow_back, color: Color(0xFF1E1E1E)),
                    text_widget(
                      "Daily Quiz",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E1E1E),
                    ),
                    const SizedBox(width: 24), // Spacer
                  ],
                ),
                SizedBox(height: 3.h),

                /// Timer Section
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF484848), Color(0xFF181818)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),

                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _timerText("02", "Hours"),
                              _colon(),
                              _timerText("30", "Minutes"),
                              _colon(),
                              _timerText("15", "Seconds"),
                            ],
                          ),
                        ],
                      ),
                    ),

                    /// Floating CTA Button
                    Positioned(
                      bottom: -2.h,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 1.h,
                            horizontal: 8.w,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF86624),
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFF86624).withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: text_widget(
                            "Next Quiz Coming",
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h), // To prevent clipping at bottom

                SizedBox(height: 14.h),

                /// Ranking Boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _rankingBox("20th", "Global Ranking", true),
                    _rankingBox("8th", "Friends Ranking", false),
                  ],
                ),

                SizedBox(height: 3.h),

                /// Leaderboard Section
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF86624),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.all(4.w),
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
                              children: [_tab("Friends"), _tab("Global")],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),

                      /// Players
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

                SizedBox(height: 3.h),

                /// Challenge Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: const Color(0xFFF86624)),
                    ),
                    child: Center(
                      child: text_widget(
                        "Challenge A Friend",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFF86624),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _timerText(String value, String label) {
    return Column(
      children: [
        text_widget(
          value,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        text_widget(label, fontSize: 13.sp, color: Colors.white),
      ],
    );
  }

  Widget _colon() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: text_widget(":", fontSize: 20.sp, color: Colors.white),
    );
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
}
