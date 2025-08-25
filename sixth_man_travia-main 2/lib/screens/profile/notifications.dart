import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/text_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> unread = List.generate(3, (_) => {});
    final List<Map<String, dynamic>> read = List.generate(2, (_) => {});

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 2.h,
          ).copyWith(bottom: 5.h), // Prevent bottom overflow
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFFF86624),
                    ),
                  ),

                  text_widget(
                    "Notifications",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1E1E1E),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
              SizedBox(height: 3.h),

              /// Unread Section
              _buildSectionLabel("Unread Notification"),
              SizedBox(height: 1.5.h),
              ...unread.map((_) => _buildNotificationCard(isUnread: true)),
              SizedBox(height: 3.h),

              /// Read Section
              _buildSectionLabel("Read Notification"),
              SizedBox(height: 1.5.h),
              ...read.map((_) => _buildNotificationCard(isUnread: false)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String title) {
    return Row(
      children: [
        text_widget(
          title,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xFFFD8225),
        ),
        const SizedBox(width: 10),
        Expanded(child: Divider(color: const Color(0xFFD3D3D3), thickness: 1)),
      ],
    );
  }

  Widget _buildNotificationCard({required bool isUnread}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.5.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.sp),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Left Bar
            Container(
              width: 1.w,
              height: 7.h,
              decoration: BoxDecoration(
                color: isUnread
                    ? const Color(0xFFFD8225) // Orange for unread
                    : const Color(0xFFB8B8B8), // Gray for read
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            SizedBox(width: 3.w),

            /// Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Top Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text_widget(
                        "Notification Heading",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F0F0F),
                      ),
                      text_widget(
                        "2 Hours ago",
                        fontSize: 12.sp,
                        color: const Color(0xFF0F0F0F),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.8.h),
                  text_widget(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been",
                    fontSize: 13.sp,
                    color: const Color(0xFF0F0F0F),
                    maxline: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
