// lib/logic/quiz_state.dart

import 'package:quiz_app/models/question_model.dart';

abstract class QuizState {}

class QuizInitial extends QuizState {}

class QuizQuestionLoaded extends QuizState {
  final QuestionModel question;
  final int timeLeft;

  QuizQuestionLoaded(this.question, this.timeLeft);
}

class QuizCompleted extends QuizState {
  final int score;
  final int totalQuestions;

  QuizCompleted(this.score, this.totalQuestions);
}
