import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/screens/home_page/TeamDetailScreen.dart';
import '../../widgets/text_widget.dart';

class TeamTriviaScreen extends StatelessWidget {
  const TeamTriviaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  text_widget(
                    "Team Trivia",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1E1E1E),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.transparent,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 2.h),

              /// Search Bar
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: const Color(0xFFE2E2E2)),
                ),

                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/search.png",
                      height: 20.sp,
                      width: 20.sp,
                    ),
                    SizedBox(width: 2.w),
                    text_widget(
                      "Search here...",
                      fontSize: 15.sp,
                      color: const Color(0xFFB9B9B9),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.5.h),

              /// Grid of Team Cards
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 4.w,
                    runSpacing: 2.h,
                    children: [
                      _teamCard(context, "LAKERS", [
                        "8/10",
                        "Not played",
                        "Not played",
                      ]),
                      _teamCard(context, "WARRIORS", [
                        "Not played",
                        "Not played",
                        "Not played",
                      ]),
                      _teamCard(context, "CELTICS", ["8/10", "8/10", "8/10"]),
                      _teamCard(context, "BULLS", [
                        "8/10",
                        "8/10",
                        "Not played",
                      ]),
                      _teamCard(context, "LAKERS", [
                        "8/10",
                        "Not played",
                        "Not played",
                      ]),
                      _teamCard(context, "WARRIORS", [
                        "Not played",
                        "Not played",
                        "Not played",
                      ]),
                      _teamCard(context, "CELTICS", ["8/10", "8/10", "8/10"]),
                      _teamCard(context, "BULLS", [
                        "8/10",
                        "8/10",
                        "Not played",
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _teamCard(BuildContext context, String teamName, List<String> scores) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TeamDetailScreen()),
        );
      },

      child: Container(
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
}
