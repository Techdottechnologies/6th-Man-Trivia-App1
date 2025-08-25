import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/text_widget.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String selectedTeam = "All Teams";
  List<String> teams = ["All Teams", "Team A", "Team B", "Team C"];

  int selectedTab = 1; // Friends
  int selectedLeaderboardTab = 1; // Friends tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header (start from top)
            Stack(
              clipBehavior: Clip.none,
              children: [
                /// Background Header
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 27.h, top: 0),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF484848), // 0% stop
                        Color(0xFF181818), // 100% stop
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 5.5.h),

                      /// Top bar
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                            text_widget(
                              "Leaderboard",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            Icon(
                              Icons.arrow_back,
                              color: Colors.transparent,
                              size: 20.sp,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 3.h),

                      /// Tabs (Global / Friends / Team)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Container(
                          height: 4.5.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2C2C2C),
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.white24, width: 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _leaderboardTab("Global", 0),
                              _leaderboardTab("Friends", 1),
                              _leaderboardTab("Team", 2),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// Top 3 Players – Bottom Overlap
                Positioned(
                  bottom: -2.h,
                  left: 0,
                  right: 0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                        child: _topPlayer(
                          "SALMAN\nALI",
                          "assets/images/player-1.png",
                          "2300",
                          "02",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                        child: _topPlayer(
                          "SALMAN\nALI",
                          "assets/images/player-2.png",
                          "2300",
                          "01",
                          showCrown: true,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                        child: _topPlayer(
                          "SALMAN\nALI",
                          "assets/images/player-3.png",
                          "2300",
                          "03",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 4.h), // gap below players
            /// Dropdown for team (only for Team tab)
            if (selectedLeaderboardTab == 2)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedTeam,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Color(0xFF9E9E9E),
                      ),
                      borderRadius: BorderRadius.circular(20),
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: const Color(0xFFFF6A00),
                        fontWeight: FontWeight.w500,
                      ),
                      dropdownColor: Colors.white,
                      items: teams.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: text_widget(
                            value,
                            fontSize: 15.sp,
                            color: value == selectedTeam
                                ? const Color(0xFFFF6A00)
                                : Colors.black,
                            fontWeight: value == selectedTeam
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedTeam = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),

            SizedBox(height: 2.5.h),

            /// Your Card
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6A00),
                  borderRadius: BorderRadius.circular(14), // more curved
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 17.sp, // slightly smaller
                      backgroundImage: const AssetImage(
                        "assets/images/player-2.png",
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          text_widget(
                            "Your Name",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          text_widget(
                            "Score",
                            fontSize: 13.sp,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ],
                      ),
                    ),
                    text_widget(
                      "Rank",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 2.h),

            /// Other Users
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              separatorBuilder: (_, __) => SizedBox(height: 1.6.h),
              itemBuilder: (_, i) => Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.6.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20), // More natural curve
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 17.sp, // Slightly smaller
                      backgroundImage:
                          const AssetImage("assets/images/player-2.png"),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          text_widget("Salman Ahmed", fontSize: 15.sp),
                          text_widget(
                            "2300",
                            fontSize: 13.sp,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    text_widget(
                      "${4 + i}th",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFF6A00),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 14.h),
          ],
        ),
      ),
    );
  }

  Widget _leaderboardTab(String label, int index) {
    final bool isSelected = selectedLeaderboardTab == index;

    // Conditional radius for each position
    BorderRadius radius = BorderRadius.zero;
    if (index == 0) {
      radius = const BorderRadius.only(
        topLeft: Radius.circular(50),
        bottomLeft: Radius.circular(50),
      );
    } else if (index == 2) {
      radius = const BorderRadius.only(
        topRight: Radius.circular(50),
        bottomRight: Radius.circular(50),
      );
    }

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedLeaderboardTab = index),
        child: Container(
          height: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: isSelected ? radius : BorderRadius.zero,
          ),
          child: text_widget(
            label,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isSelected ? const Color(0xFFFF6A00) : Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _topPlayer(
    String name,
    String img,
    String score,
    String rank, {
    bool showCrown = false,
  }) {
    final bool isCenter = rank == "01";

    return Column(
      children: [
        if (showCrown)
          Padding(
            padding: EdgeInsets.only(bottom: 0.5.h),
            child: Image.asset('assets/images/crown.png', height: 4.2.h),
          ),

        /// Card
        Container(
          height: isCenter ? 19.5.h : 17.h,
          width: 27.w,
          decoration: BoxDecoration(
            color: const Color(0xFF3B3B3B),
            borderRadius: BorderRadius.only(
              bottomLeft: rank == "02"
                  ? const Radius.circular(61)
                  : Radius.circular(14.sp),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 1.6.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: isCenter ? 18.sp : 15.sp,
                backgroundImage: AssetImage(img),
              ),
              SizedBox(height: 1.h),
              text_widget(
                name,
                fontSize: 13.sp,
                color: Colors.white,
                textAlign: TextAlign.center,
              ),
              text_widget(
                score,
                fontSize: 13.sp,
                color: const Color(0xFFFF6A00),
              ),
            ],
          ),
        ),

        SizedBox(height: isCenter ? 2.h : 2.h),
      ],
    );
  }
}
