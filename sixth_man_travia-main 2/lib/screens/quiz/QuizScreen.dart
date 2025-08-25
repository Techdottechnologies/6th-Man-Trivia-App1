import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/model/quiz.dart';
import 'package:sixth_man_travia/screens/quiz/QuizResultScreen.dart';
import '../../widgets/text_widget.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Map<String, List<QuizModel>> categoryWiseQuestions = {};
  List<QuizModel> allQuestions = [];
  List<String> categoriesOrder = ["IQ", "Sports", "General"];

  int currentIndex = 0;
  int score = 0;
  int selectedIndex = -1;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    try {
      for (final cat in categoriesOrder) {
        final snapshot = await FirebaseFirestore.instance
            .collection('quiz')
            .where('category', isEqualTo: cat)
            .limit(10)
            .get();

        final questions = snapshot.docs
            .map((doc) => QuizModel.fromJson(doc.data(), doc.id))
            .toList();

        categoryWiseQuestions[cat] = questions;
      }
      allQuestions = categoriesOrder
          .expand((cat) => categoryWiseQuestions[cat] ?? <QuizModel>[])
          .toList();
    } catch (e) {
      print('❌ Error fetching questions: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  void nextQuestion() {
    if (selectedIndex == allQuestions[currentIndex].answerIndex) {
      score++;
    }

    if (currentIndex < allQuestions.length - 1) {
      setState(() {
        currentIndex++;
        selectedIndex = -1;
      });
    } else {
      Get.off(() => QuizResultScreen(score: score, total: allQuestions.length));
    }
  }

  void previousQuestion() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        selectedIndex = -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: CircularProgressIndicator(
          color: Color(0xFFF86624),
        )),
      );
    }

    if (allQuestions.isEmpty) {
      return Scaffold(
        body: Center(
          child: text_widget("No questions available.",
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600),
        ),
      );
    }

    final currentQ = allQuestions[currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(90)),
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                left: 5.w,
                right: 5.w,
                bottom: 3.h,
              ),
              width: 100.w,
              height: 30.h + MediaQuery.of(context).padding.top,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF484848), Color(0xFF181818)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      width: 70.w,
                      child: LinearProgressIndicator(
                        value: (currentIndex + 1) / allQuestions.length,
                        backgroundColor: Colors.grey[800],
                        valueColor:
                            const AlwaysStoppedAnimation(Color(0xFFF86624)),
                        minHeight: 1.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Center(
                    child: text_widget(
                      "${currentQ.category} Quiz",
                      fontSize: 16.sp,
                      color: Colors.white.withOpacity(0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 0.7.h),
                  Center(
                    child: text_widget(
                      currentQ.question,
                      maxline: 3,
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Center(
                    child: text_widget(
                      "${(currentIndex + 1).toString().padLeft(2, '0')}/${allQuestions.length.toString().padLeft(2, '0')}",
                      fontSize: 14.sp,
                      color: const Color(0xFFF86624),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    child: Column(
                      children: List.generate(currentQ.options.length, (index) {
                        final isSelected = index == selectedIndex;
                        return GestureDetector(
                          onTap: () => setState(() => selectedIndex = index),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2.h),
                            padding: EdgeInsets.symmetric(
                              vertical: 1.4.h,
                              horizontal: 6.w,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFFF86624)
                                    : const Color(0xFFE2E2E2),
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              children: [
                                text_widget(
                                  '${String.fromCharCode(65 + index)}.',
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? const Color(0xFFF86624)
                                      : const Color(0xFF838383),
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                  child: text_widget(
                                    currentQ.options[index],
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected
                                        ? const Color(0xFFF86624)
                                        : const Color(0xFF1E1E1E),
                                  ),
                                ),
                                Container(
                                  width: 18.sp,
                                  height: 18.sp,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFFF86624)
                                          : Colors.grey.shade400,
                                      width: 2,
                                    ),
                                    color: isSelected
                                        ? const Color(0xFFF86624)
                                        : Colors.transparent,
                                  ),
                                  child: isSelected
                                      ? const Icon(Icons.check,
                                          color: Colors.white, size: 14)
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      children: [
                        _quizButton(
                          currentIndex == allQuestions.length - 1
                              ? "Finish & See Result"
                              : "Save & Next Question",
                          const Color(0xFFF86624),
                          nextQuestion,
                          enabled: selectedIndex != -1,
                        ),
                        SizedBox(height: 1.5.h),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: _gradientButton("Back"),
                        ),
                        SizedBox(height: 2.h),
                        GestureDetector(
                          onTap: previousQuestion,
                          child: text_widget(
                            "Previous Question",
                            fontSize: 15.sp,
                            color: const Color(0xFFF86624),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        SizedBox(height: 3.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quizButton(String title, Color bgColor, VoidCallback onTap,
      {bool enabled = true}) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0.w),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 1.6.h),
          decoration: BoxDecoration(
            color: enabled ? bgColor : Colors.grey,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: text_widget(
              title,
              fontSize: 15.5.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _gradientButton(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 1.6.h),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF484848), Color(0xFF181818)],
          ),
        ),
        child: Center(
          child: text_widget(
            title,
            fontSize: 15.5.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
