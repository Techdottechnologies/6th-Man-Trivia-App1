import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/new_screens/profile_upated/Subscription/CheckoutScreen.dart';
import 'package:sixth_man_travia/screens/auth/login.dart';
import 'package:sixth_man_travia/widgets/text_widget.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

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
              const Icon(Icons.arrow_back, color: Color(0xFFF86624)),
              SizedBox(height: 2.h),
              Center(
                child: text_widget(
                  "Subscription",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5.h),

              /// Orange Plan Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 60.h,
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF86624),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text_widget(
                        "Monthly Plan",
                        fontSize: 17.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 1.h),
                      text_widget(
                        "\$4.45",
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      SizedBox(height: 2.h),
                
                      /// Divider line
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      SizedBox(height: 2.h),
                
                      /// Features list
                      ...[
                        "Add Free App",
                        "Lorem Ipsum is simply",
                        "24–Hour Visibility",
                        "Instant Visibility",
                        "Short–Term Impact",
                        "Memorable Impression",
                      ].map(
                        (item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12 ),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 3.5,
                                backgroundColor: Colors.white,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: text_widget(
                                  item,
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                
                      SizedBox(height: 4.h),
                
                      /// Choose Plan Button
                      GestureDetector(
                        onTap: () {
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (_) => const CheckoutScreen(),
                          //   ),
                          // );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 1.6.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: const Color(0xFFF86624),
                              width: 1.2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: text_widget(
                            "Choose Plan",
                            fontSize: 16.sp,
                            color: const Color(0xFFF86624),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              /// Page indicator dots
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 4,
                      backgroundColor: Color(0xFFF86624),
                    ),
                    SizedBox(width: 8),
                    const CircleAvatar(
                      radius: 4,
                      backgroundColor: Color(0xFFE0E0E0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
