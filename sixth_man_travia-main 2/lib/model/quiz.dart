class QuizModel {
  final String id;
  final String category;
  final String question;
  final List<String> options;
  final int answerIndex;

  QuizModel({
    required this.id,
    required this.category,
    required this.question,
    required this.options,
    required this.answerIndex,
  });

  Map<String, dynamic> toJson() => {
        'category': category,
        'question': question,
        'options': options,
        'answerIndex': answerIndex,
      };

  factory QuizModel.fromJson(Map<String, dynamic> json, String id) {
    return QuizModel(
      id: id,
      category: json['category'],
      question: json['question'],
      options: List<String>.from(json['options']),
      answerIndex: json['answerIndex'],
    );
  }
}