import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/new_screens/CrossWord/HomeScreen.dart';
import 'package:sixth_man_travia/screens/leaderboard/Leader_Board.dart';
import 'package:sixth_man_travia/screens/freinds/FriendsScreen.dart';
import 'package:sixth_man_travia/screens/home_page/homePage.dart';
import 'package:sixth_man_travia/screens/profile/profile_screen.dart';
import 'package:sixth_man_travia/screens/quiz/home_screen.dart';
import '../../screens/auth/login.dart';
import '../../screens/auth/signup.dart';
import '../../widgets/text_widget.dart';

class CustomMainBottomNav extends StatefulWidget {
  final int currentIndex;
  const CustomMainBottomNav({super.key, required this.currentIndex});

  @override
  State<CustomMainBottomNav> createState() => _CustomMainBottomNavState();
}

class _CustomMainBottomNavState extends State<CustomMainBottomNav> {
  late int _currentIndex;

  @override
  void initState() {
    _currentIndex = widget.currentIndex;
    super.initState();
  }

  final List<Widget> _pages = [
    const HomeScreen(),
    const QuizHomeScreen(),
    const CrosswordHomeScreen(),
    const LeaderboardScreen(),
    const ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        height: 10.h,
        decoration: const BoxDecoration(
          color: Color(0xFF1C1C1C),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
          ),
        ),
        padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 1.2.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navItem(0, Icons.home, "Home"),
            _navItem(1, Icons.help_outline, "Quiz"),
            _navItem(2, Icons.help_outline, "Crossword", true),
            _navItem(3, Icons.bar_chart_outlined, "Leaderboard"),
            _navItem(4, Icons.person_outline, "Profile"),
          ],
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label,
      [bool crossword = false]) {
    final bool isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 4.5.h,
            width: 4.5.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? const Color(0xFFFF6A00) : Colors.transparent,
            ),
            child: crossword
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/crossword.png',
                        // height: 8.sp,
                        fit: BoxFit.contain,
                        color: isSelected ? Colors.white : Colors.grey),
                  )
                : Icon(
                    icon,
                    size: 20.sp,
                    color: isSelected ? Colors.white : Colors.grey,
                  ),
          ),
          SizedBox(height: 0.5.h),
          text_widget(
            label,
            fontSize: 13.sp,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
            color: isSelected ? Colors.white : Colors.grey,
          ),
        ],
      ),
    );
  }
}
