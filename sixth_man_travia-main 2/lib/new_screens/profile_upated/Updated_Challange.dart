import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/new_screens/profile_upated/see_details.dart';
import 'package:sixth_man_travia/widgets/custom_nav.dart';
import '../../widgets/text_widget.dart';

class UpdatedChallengesScreen extends StatefulWidget {
  const UpdatedChallengesScreen({super.key});

  @override
  State<UpdatedChallengesScreen> createState() =>
      _UpdatedChallengesScreenState();
}

class _UpdatedChallengesScreenState extends State<UpdatedChallengesScreen> {
  String activeTab = "Sent";

  final List<Map<String, dynamic>> sentChallenges = [
    {
      "type": "Team",
      "name": "Salman Ahmed",
      "id": "#349833",
      "message": "You can’t beat my 200XP on the Lakers Superfan quiz!",
      "score": "200XP",
    },
    {"type": "Quiz", "name": "Salman Ahmed", "id": "#349833", "score": "300XP"},
    {
      "type": "Team",
      "name": "Salman Ahmed",
      "id": "#349833",
      "message": "You can’t beat my 200XP on the Lakers Superfan quiz!",
      "score": "200XP",
    },
    {"type": "Quiz", "name": "Salman Ahmed", "id": "#349833", "score": "300XP"},
  ];

  final List<Map<String, dynamic>> receivedChallenges = [
    {
      "type": "Team",
      "name": "Salman Ahmed",
      "id": "#349833",
      "message": "You can’t beat my 200XP on the Lakers Superfan quiz!",
    },
    {"type": "Quiz", "name": "Salman Ahmed", "id": "#349833", "score": "300XP"},
  ];

  @override
  Widget build(BuildContext context) {
    final challenges =
        activeTab == "Sent" ? sentChallenges : receivedChallenges;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFFFF), Color(0xFFE7E7E7)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const CustomMainBottomNav(currentIndex: 4),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFFFF6A00),
                      ),
                    ),
                    text_widget(
                      "Challenges",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(width: 24),
                  ],
                ),
                SizedBox(height: 3.h),
                Container(
                  height: 6.5.h,
                  width: double.infinity,
                  padding: EdgeInsets.all(0.5.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEDED),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    children: [_buildToggle("Sent"), _buildToggle("Received")],
                  ),
                ),
                SizedBox(height: 3.h),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: challenges.length,
                  separatorBuilder: (_, __) => SizedBox(height: 5.h),
                  itemBuilder: (_, i) {
                    final item = challenges[i];
                    final isQuiz = item["type"] == "Quiz";
                    final isWhite = item["message"] != null;
                    final isOrange = !isWhite;
                    final isReceived = activeTab == "Received";

                    return Stack(
                      alignment: Alignment.bottomCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 2.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: isWhite
                                ? Colors.white
                                : const Color(0xFFFF6A00),
                            borderRadius: BorderRadius.circular(18.sp),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 17.sp,
                                    backgroundImage: const AssetImage(
                                      "assets/images/player-2.png",
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        text_widget(
                                          item["name"],
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                          color: isWhite
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                        text_widget(
                                          item["id"],
                                          fontSize: 13.sp,
                                          color: isWhite
                                              ? const Color(0xFF9A9A9A)
                                              : Colors.white70,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if (item["type"] != null)
                                        text_widget(
                                          item["type"],
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: isWhite
                                              ? const Color(0xFFFF6A00)
                                              : Colors.white,
                                        ),
                                      if (item["score"] != null)
                                        text_widget(
                                          item["score"],
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: isWhite
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              if (item["message"] != null) ...[
                                SizedBox(height: 3.5.h),
                                text_widget(
                                  item["message"],
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFFF6A00),
                                ),
                                SizedBox(height: 3.h),
                              ] else
                                SizedBox(height: 6.5.h),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: -2.h,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const ChallengeDetailScreen(),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 7.w,
                                    vertical: 0.9.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: text_widget(
                                    "See Details",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFFF6A00),
                                  ),
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 7.w,
                                  vertical: 0.9.h,
                                ),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF484848),
                                      Color(0xFF181818),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: text_widget(
                                  isReceived
                                      ? "Take Quiz"
                                      : (item["score"] ?? "Delete"),
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildToggle(String label) {
    final bool isActive = activeTab == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => activeTab = label),
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFF86624) : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
          ),
          alignment: Alignment.center,
          child: text_widget(
            label,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: isActive ? Colors.white : const Color(0xFF1E1E1E),
          ),
        ),
      ),
    );
  }
}
