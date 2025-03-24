// lib/models/question_model.dart

class QuestionModel {
  final int id;
  final String question;
  final List<String> answers;
  final String correctAnswer;

  QuestionModel({
    required this.id,
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });
}
