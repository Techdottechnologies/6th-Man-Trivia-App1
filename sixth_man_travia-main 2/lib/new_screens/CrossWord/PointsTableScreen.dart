import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/text_widget.dart';

class PointsTableScreen extends StatelessWidget {
  const PointsTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> data = [
      {"name": "Per Correct Word", "points": "+100XP"},
      {"name": "Speed Bonus (under 3 mins)", "points": "+100XP"},
      {"name": "No Hints Used", "points": "+100XP"},
      {"name": "Streak Bonus (Day 5)", "points": "+100XP"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            SizedBox(height: 8.h),

            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Color(0xFFF86624)),
                ),
                text_widget(
                  "Points Table",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E1E1E),
                ),
                SizedBox(width: 24), // For symmetry
              ],
            ),

            SizedBox(height: 5.h),

            /// Table
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Table(
                border: TableBorder.symmetric(
                  inside: BorderSide(color: Colors.grey.shade300),
                ),
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                },
                children: [
                  /// Header row
                  TableRow(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: Center(
                          child: text_widget(
                            "Name",
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFF86624),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: Center(
                          child: text_widget(
                            "Points",
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFF86624),
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// Data rows
                  for (var item in data)
                    TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          child: Center(
                            child: text_widget(
                              item["name"]!,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          child: Center(
                            child: text_widget(
                              item["points"]!,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
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
