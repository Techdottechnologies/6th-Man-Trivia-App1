import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/text_widget.dart';

class SelectFriendScreen extends StatelessWidget {
  const SelectFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> friends = List.generate(
      10,
      (index) => {
        'name': 'Salman Ahmed',
        'id': '#349833',
        'avatar': 'assets/images/player-2.png',
      },
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFFFFF), Color(0xFFE7E7E7)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.arrow_back, color: Colors.black),

                    text_widget(
                      "Challenge Friend",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1E1E1E),
                    ),
                    const Icon(Icons.arrow_back, color: Colors.transparent),
                  ],
                ),
                SizedBox(height: 4.h),

                /// Title
                Center(
                  child: text_widget(
                    "Select friends",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFF86624),
                  ),
                ),
                SizedBox(height: 4.h),

                /// Friends List
                Expanded(
                  child: ListView.separated(
                    itemCount: friends.length,
                    separatorBuilder: (_, __) => SizedBox(height: 2.h),
                    itemBuilder: (context, index) {
                      final friend = friends[index];
                      return Container(
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
                              backgroundImage: AssetImage(friend['avatar']!),
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text_widget(
                                    friend['name']!,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF1E1E1E),
                                  ),
                                    SizedBox(height: 0.5.h),
                                    text_widget(
                                    friend['id']!,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF838383),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(1.5.h),
                              decoration: const BoxDecoration(
                                color: Color(0xFFF86624),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.person_add,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                /// Send Button
                SizedBox(height: 3.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 1.8.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF86624),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: text_widget(
                        "Send",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
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
}
