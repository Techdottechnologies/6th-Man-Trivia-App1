import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/model/quiz.dart';
import 'package:sixth_man_travia/widgets/text_widget.dart';

class AddQuestionScreen extends StatefulWidget {
  const AddQuestionScreen({super.key});

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final TextEditingController questionController = TextEditingController();
  final List<TextEditingController> optionControllers =
      List.generate(4, (_) => TextEditingController());

  int correctAnswerIndex = -1;
  String selectedCategory = "IQ";

  final List<String> categories = ["IQ", "Sports", "General"];

  void addQuestion() async {
    if (questionController.text.isEmpty ||
        optionControllers.any((c) => c.text.isEmpty) ||
        correctAnswerIndex == -1) {
      Get.snackbar("Missing Fields", "Please fill in all fields properly.",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final newQuestion = QuizModel(
      id: '', // Firestore will assign
      category: selectedCategory,
      question: questionController.text,
      options: optionControllers.map((c) => c.text).toList(),
      answerIndex: correctAnswerIndex,
    );

    try {
      await FirebaseFirestore.instance
          .collection('quiz')
          .add(newQuestion.toJson());

      Get.snackbar("Success", "Question added successfully!",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);

      // Clear for next
      questionController.clear();
      for (var c in optionControllers) {
        c.clear();
      }
      correctAnswerIndex = -1;
      setState(() {});
    } catch (e) {
      Get.snackbar("Error", "Failed to add question",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back, color: Colors.black)),
                  text_widget(
                    "",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  const Icon(Icons.arrow_back, color: Colors.transparent),
                ],
              ),
              SizedBox(height: 1.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 4.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF484848), Color(0xFF181818)],
                  ),
                  borderRadius: BorderRadius.circular(22.sp),
                ),
                child: Center(
                  child: text_widget(
                    "Add Quiz Question",
                    fontSize: 17.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              text_widget("Select Category",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              SizedBox(height: 1.h),
              Wrap(
                spacing: 2.w,
                children: categories.map((cat) {
                  final isSelected = selectedCategory == cat;
                  return ChoiceChip(
                    label: text_widget(cat,
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp),
                    selected: isSelected,
                    onSelected: (_) => setState(() => selectedCategory = cat),
                    selectedColor: const Color(0xFFF86624),
                    backgroundColor: const Color(0xFFE2E2E2),
                  );
                }).toList(),
              ),
              SizedBox(height: 3.h),
              text_widget("Question",
                  fontSize: 16.sp, fontWeight: FontWeight.bold),
              SizedBox(height: 1.h),
              _inputField(
                  controller: questionController,
                  hint: "Enter your question here..."),
              SizedBox(height: 3.h),
              text_widget("Options",
                  fontSize: 16.sp, fontWeight: FontWeight.bold),
              SizedBox(height: 1.h),
              ...List.generate(4, (index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => correctAnswerIndex = index),
                        child: Container(
                          width: 18.sp,
                          height: 18.sp,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: correctAnswerIndex == index
                                  ? const Color(0xFFF86624)
                                  : Colors.grey,
                              width: 2,
                            ),
                            color: correctAnswerIndex == index
                                ? const Color(0xFFF86624)
                                : Colors.transparent,
                          ),
                          child: correctAnswerIndex == index
                              ? const Icon(Icons.check,
                                  color: Colors.white, size: 14)
                              : null,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: _inputField(
                          controller: optionControllers[index],
                          hint: "Option ${index + 1}",
                        ),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: 4.h),
              _quizButton("Add Question", const Color(0xFFF86624), addQuestion),
              SizedBox(
                height: 2.h,
              ),
              const Divider(),
              SizedBox(height: 1.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 4.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF484848), Color(0xFF181818)],
                  ),
                  borderRadius: BorderRadius.circular(22.sp),
                ),
                child: Center(
                  child: text_widget(
                    "Previous Questions",
                    fontSize: 17.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              SizedBox(height: 60.h, child: const PreviousQuestionsList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(
      {required TextEditingController controller, String? hint}) {
    return TextField(
      controller: controller,
      style: TextStyle(fontSize: 15.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFFF2F2F2),
        contentPadding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 4.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _quizButton(String title, Color bgColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 1.6.h),
        decoration: BoxDecoration(
          color: bgColor,
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
    );
  }
}

class PreviousQuestionsList extends StatefulWidget {
  const PreviousQuestionsList({super.key});

  @override
  State<PreviousQuestionsList> createState() => _PreviousQuestionsListState();
}

class _PreviousQuestionsListState extends State<PreviousQuestionsList> {
  List<QuizModel> allQuestions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('quiz')
          .orderBy('category')
          .get();

      setState(() {
        allQuestions = snapshot.docs
            .map((doc) => QuizModel.fromJson(doc.data(), doc.id))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print("❌ Error fetching questions: $e");
      setState(() => isLoading = false);
    }
  }

  Future<void> deleteQuestion(String id) async {
    await FirebaseFirestore.instance.collection('quiz').doc(id).delete();
    setState(() {
      allQuestions.removeWhere((q) => q.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (allQuestions.isEmpty) {
      return Center(
        child: text_widget(
          "No questions found.",
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      itemCount: allQuestions.length,
      separatorBuilder: (_, __) => SizedBox(height: 1.5.h),
      itemBuilder: (context, index) {
        final q = allQuestions[index];
        return Container(
          padding: EdgeInsets.all(2.h),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE2E2E2), width: 1),
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text_widget(
                      "${q.category} - ${q.question}",
                      maxline: 2,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      color: Colors.black,
                    ),
                    SizedBox(height: 1.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(q.options.length, (i) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 0.5.h),
                          child: text_widget(
                            "${String.fromCharCode(65 + i)}. ${q.options[i]}",
                            fontSize: 14.sp,
                            color: i == q.answerIndex
                                ? const Color(0xFFF86624)
                                : Colors.grey.shade800,
                            fontWeight: i == q.answerIndex
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    title: text_widget(
                      "Delete Question?",
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    content: text_widget(
                      "Are you sure you want to delete this question?",
                      fontSize: 14.sp,
                      color: Colors.black87,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: text_widget("Cancel",
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          deleteQuestion(q.id);
                        },
                        child: text_widget("Delete",
                            color: const Color(0xFFF86624),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
