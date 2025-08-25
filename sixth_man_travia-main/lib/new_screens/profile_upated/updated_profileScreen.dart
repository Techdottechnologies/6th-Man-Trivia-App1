import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/new_screens/profile_upated/SharesScreen.dart';
import 'package:sixth_man_travia/new_screens/profile_upated/Subscription/SubscriptionScreen.dart';
import 'package:sixth_man_travia/screens/auth/change_password.dart';
import 'package:sixth_man_travia/screens/auth/login.dart';
import 'package:sixth_man_travia/screens/profile/ChallengesScreen.dart';
import 'package:sixth_man_travia/screens/profile/edit_profile.dart';
import 'package:sixth_man_travia/screens/profile/notifications.dart';
import 'package:sixth_man_travia/screens/profile/your_stats.dart';
import '../../widgets/text_widget.dart';

class UpdatedProfile extends StatelessWidget {
  const UpdatedProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFFFFF), // white
            Color(0xFFE7E7E7), // soft grey
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Important
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              children: [
                SizedBox(height: 2.h),

                /// Back + Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.arrow_back, color: Colors.black),
                    text_widget(
                      "Profile",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    const Icon(Icons.arrow_back, color: Colors.transparent),
                  ],
                ),

                SizedBox(height: 3.h),

                /// Orange Profile Header
                Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6A00),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.sp,
                        backgroundImage: const AssetImage(
                          "assets/images/player-2.png",
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            text_widget(
                              "Salman Saleem",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            text_widget(
                              "#359333",
                              fontSize: 13.sp,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const EditProfileScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(1.2.h),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: const Color(0xFFFF6A00),
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 3.h),

                /// Tiles (90% width)
                _tile(
                  context,
                  Icons.lock_outline,
                  "Change Password",
                  const ChangePasswordScreen(),
                ),
                _tile(
                  context,
                  Icons.emoji_events_outlined,
                  "Challenges",
                  const ChallengesScreen(),
                ),
                _tile(
                  context,
                  Icons.bar_chart_rounded,
                  "Your Stats",
                  const YourStats(),
                ),
                _tile(
                  context,
                  Icons.notifications_none_rounded,
                  "Notifications",
                  const NotificationScreen(),
                ),
                _tile(context, Icons.person_outline_rounded, "Friends", null),
                _tile(
                  context,
                  Icons.share_outlined,
                  "Shares",
                  const SharesScreen(),
                ),
                _tile(
                  context,
                  Icons.workspace_premium_outlined,
                  "Subscription",
                  const SubscriptionScreen(),
                ),

                const Spacer(),

                /// Logout Button
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 1.6.h),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF484848), Color(0xFF181818)],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment: Alignment.center,
                    child: text_widget(
                      "Logout",
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tile(
    BuildContext context,
    IconData icon,
    String label,
    Widget? page,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.4.h),
      child: GestureDetector(
        onTap: page != null
            ? () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => page),
                )
            : null,
        child: Container(
          width: 90.w,
          padding: EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 4.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFFFF6A00), size: 20.sp),
              SizedBox(width: 3.w),
              text_widget(
                label,
                fontSize: 15.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
