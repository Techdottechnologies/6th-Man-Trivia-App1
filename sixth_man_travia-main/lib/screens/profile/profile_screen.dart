import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/Controllers/authcontroller.dart';
import 'package:sixth_man_travia/config.dart';
import 'package:sixth_man_travia/screens/auth/change_password.dart';
import 'package:sixth_man_travia/screens/auth/login.dart';
import 'package:sixth_man_travia/screens/profile/ChallengesScreen.dart';
import 'package:sixth_man_travia/screens/profile/edit_profile.dart';
import 'package:sixth_man_travia/screens/profile/notifications.dart';
import 'package:sixth_man_travia/screens/profile/your_stats.dart';
import '../../widgets/text_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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

              /// Orange Profile Tile
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6A00),
                  borderRadius: BorderRadius.circular(18.sp),
                ),
                child: Row(
                  children: [
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
                              errorWidget: Icon(Icons.error,
                                  size: 3.h, color: Colors.red),
                            ),
                          ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text_widget(
                            currentUser.name,
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
                    Container(
                      height: 4.h, width: 4.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      // padding: EdgeInsets.all(1.2.h),
                      child: GestureDetector(
                        onTap: () async {
                          await Get.to(const EditProfileScreen());
                          setState(
                              () {}); // Refresh the profile screen after editing
                        },
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

              SizedBox(height: 3.5.h),

              /// Option Tiles
              GestureDetector(
                onTap: () {
                  Get.to(const ChangePasswordScreen());
                },
                child: _optionTile(Icons.password, "Change password"),
              ),
              SizedBox(height: 1.4.h),
              GestureDetector(
                onTap: () {
                  Get.to(const ChallengesScreen());
                },
                child: _optionTile(Icons.emoji_events_outlined, "Challenges"),
              ),

              SizedBox(height: 1.4.h),
              GestureDetector(
                onTap: () {
                  Get.to(const YourStats());
                },
                child: _optionTile(Icons.bar_chart, "Your Stats"),
              ),
              SizedBox(height: 1.4.h),

              GestureDetector(
                onTap: () {
                  Get.to(const NotificationScreen());
                },
                child: _optionTile(
                  Icons.notifications_outlined,
                  "Notifications",
                ),
              ),

              const Spacer(),

              /// Logout Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.0.w),
                child: GestureDetector(
                  onTap: () async {
                    // Get.find<DrawerControllerX>().closeDrawer();
                    await Get.find<AuthController>().logout();
                    Get.off(const LoginScreen());
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 1.6.h),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF484848), // top
                          Color(0xFF181818), // bottom
                        ],
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
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Option Tile Widget
  Widget _optionTile(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.4.h),
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
    );
  }
}
