import 'dart:async';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/new_screens/QuizResultScreen2.dart';
import '../../widgets/text_widget.dart';

class QuizQuestionScreen extends StatefulWidget {
  const QuizQuestionScreen({super.key});

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  int selectedIndex = -1;
  int currentIndex = 0;
  late Timer timer;
  Duration elapsed = Duration.zero;

  final List<Map<String, dynamic>> questions = [
    {
      "question":
          "Which player holds the record for the most points scored in a single NBA game?",
      "options": [
        "Michael Jordan",
        "Kobe Bryant",
        "Wilt Chamberlain",
        "LeBron James",
      ],
      "correctIndex": 2,
    },
    {
      "question": "Which country hosted the 2016 Summer Olympics?",
      "options": ["China", "Brazil", "UK", "Russia"],
      "correctIndex": 1,
    },
    {
      "question": "Which planet is known as the Red Planet?",
      "options": ["Venus", "Jupiter", "Saturn", "Mars"],
      "correctIndex": 3,
    },
  ];

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => elapsed += const Duration(seconds: 1));
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _nextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        selectedIndex = -1;
      });
    } else {
      timer.cancel(); // Stop timer before navigating
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const QuizResultScreen2()),
      );
    }
  }

@override
Widget build(BuildContext context) {
  final questionData = questions[currentIndex];
  final totalQuestions = questions.length;
  final hours = elapsed.inHours.toString().padLeft(2, '0');
  final minutes = (elapsed.inMinutes % 60).toString().padLeft(2, '0');
  final seconds = (elapsed.inSeconds % 60).toString().padLeft(2, '0');

  return Scaffold(
    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFE7E7E7),
          ],
        ),
      ),
      child: Column(
        children: [
          // Top Bar (unchanged)
          Container(
            width: 100.w,
            padding: EdgeInsets.fromLTRB(5.w, 6.h, 5.w, 6.h),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF484848), Color(0xFF181818)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(80),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Progress Bar
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: LinearProgressIndicator(
                      value: (currentIndex + 1) / totalQuestions,
                      minHeight: 1.2.h,
                      backgroundColor: Colors.grey.shade700,
                      valueColor: const AlwaysStoppedAnimation(Color(0xFFFF6A00)),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),

                /// Question Header
                Center(
                  child: text_widget(
                    "Question # ${currentIndex + 1}",
                    fontSize: 15.sp,
                    color: Colors.white.withOpacity(0.6),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 1.2.h),
                Center(
                  child: text_widget(
                    questionData["question"],
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 5.h),

                /// Timer and Index
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 9.w),
                      child: text_widget(
                        "${currentIndex + 1}/$totalQuestions",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFF6A00),
                      ),
                    ),
                    text_widget(
                      "$hours : $minutes : $seconds",
                      fontSize: 14.5.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFF6A00),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 3.5.h),

          /// Options and Actions
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: ListView(
                children: [
                  ...List.generate(questionData["options"].length, (index) {
                    final optionText = questionData["options"][index];
                    return _optionTile("${String.fromCharCode(65 + index)}. $optionText", index);
                  }),
                  SizedBox(height: 4.h),
                  GestureDetector(
                    onTap: _nextQuestion,
                    child: _buildActionButton(
                      currentIndex == totalQuestions - 1 ? "Quiz Result" : "Saved & Next Question",
                      const Color(0xFFFF6A00),
                      Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  _gradientButton("Back"),
                  SizedBox(height: 1.5.h),
                  Center(
                    child: InkWell(
                      onTap: () {
                        if (currentIndex > 0) {
                          setState(() {
                            currentIndex--;
                            selectedIndex = -1;
                          });
                        }
                      },
                      child: text_widget(
                        "Previous Question",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFF86624),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.5.h),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


  Widget _optionTile(String text, int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: Container(
        margin: EdgeInsets.only(bottom: 1.5.h),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.4.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF6A00) : Colors.transparent,
            width: 1.6,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: text_widget(
                text,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? const Color(0xFFFF6A00) : Colors.black,
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected
                  ? const Color(0xFFFF6A00)
                  : Colors.grey.shade400,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _gradientButton(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 1.4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF484848), Color(0xFF181818)],
        ),
      ),
      child: Center(
        child: text_widget(
          title,
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, Color bgColor, Color textColor) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 1.4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: text_widget(
          label,
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
