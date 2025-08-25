import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/text_widget.dart';

class SharesScreen extends StatefulWidget {
  const SharesScreen({super.key});

  @override
  State<SharesScreen> createState() => _SharesScreenState();
}

class _SharesScreenState extends State<SharesScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Back + Title
              Row(
                children: [
                  const Icon(Icons.arrow_back, color: Color(0xFFF86624)),
                  const Spacer(),
                  text_widget(
                    "Shares",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  const Spacer(),
                  const Opacity(opacity: 0, child: Icon(Icons.arrow_back)),
                ],
              ),
              SizedBox(height: 2.h),

              /// Toggle Tabs
              Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEDED),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [_tabButton("Sent", 0), _tabButton("Received", 1)],
                ),
              ),
              SizedBox(height: 2.h),

              /// List
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (_, index) => _shareTile(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabButton(String label, int index) {
    final isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = index;
          });
        },
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFF86624) : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: text_widget(
              label,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _shareTile() {
    final isSentTab = selectedTab == 0;

    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFF86624)
              .withOpacity(0.2), // Light orange thin border
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Profile
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              "assets/images/player-2.png",
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),

          /// Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text_widget(
                  "Salman Ahmed",
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
                text_widget(
                  "#349833",
                  fontSize: 14.sp,
                  color: Colors.black.withOpacity(0.5),
                ),
                SizedBox(height: 1.h),
                text_widget(
                  "I just scored 1,600 XP on today’s Crossword. Think you can beat me?",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFF86624),
                ),
              ],
            ),
          ),

          /// Action Button
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              if (isSentTab) {
                // DELETE action
                print("Deleted");
              } else {
                // PLAY GAME action
                print("Play Game");
                // Add Navigator if needed
              }
            },
            child: Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: text_widget(
                  isSentTab ? "Delete" : "Play Game",
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
