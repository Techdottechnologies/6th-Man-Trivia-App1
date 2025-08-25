import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/screens/freinds/FriendDetailsScreen.dart';
import '../../widgets/text_widget.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  String activeTab = "All Users";

  final List<Map<String, String>> users = List.generate(
    10,
    (index) => {
      'name': 'Salman Ahmed',
      'id': '#549853',
      'avatar': 'assets/images/player-2.png',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back, color: Color(0xFFF86624)),
                  text_widget(
                    "Friends",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(width: 24),
                ],
              ),
              SizedBox(height: 3.h),

              /// Toggle Buttons
              Container(
                height: 6.5.h,
                width: double.infinity,
                padding: EdgeInsets.all(0.5.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEDED),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    _buildToggle("All Users"),
                    _buildToggle("Friends"),
                  ],
                ),
              ),
              SizedBox(height: 3.h),

              /// Search Bar
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEEEEE),
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
                      color: const Color(0xFF838383),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h),

              /// List View
              Expanded(
                child: ListView.separated(
                  itemCount: users.length,
                  separatorBuilder: (_, __) => SizedBox(height: 2.h),
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(const FriendDetailsScreen());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 1.2.h,
                            horizontal: 4.w,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18.sp),
                            border: Border.all(color: const Color(0x1AF86624)),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 18.sp,
                                backgroundImage: AssetImage(user['avatar']!),
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    text_widget(
                                      user['name']!,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF1E1E1E),
                                    ),
                                    SizedBox(height: 0.5.h),
                                    text_widget(
                                      user['id']!,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF838383),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(1.5.h),
                                decoration: BoxDecoration(
                                  color: activeTab == "All Users"
                                      ? const Color(0xFFF86624)
                                      : const Color(0xFFF86624),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  activeTab == "All Users"
                                      ? Icons.person_add
                                      : Icons.delete,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Toggle Widget
  Expanded _buildToggle(String title) {
    final bool isActive = activeTab == title;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => activeTab = title),
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFF86624) : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
          ),
          alignment: Alignment.center,
          child: text_widget(
            title,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: isActive ? Colors.white : const Color(0xFF1E1E1E),
          ),
        ),
      ),
    );
  }
}
