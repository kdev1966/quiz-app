// lib/logic/quiz_cubit.dart

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/logic/quiz_state.dart';
import 'package:quiz_app/data/questions.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial());

  int currentQuestionIndex = 0;
  int score = 0;
  Timer? timer;
  int timeLeft = 60;

  // This function is called when the user starts the quiz
  void startQuiz() {
    emit(QuizQuestionLoaded(questions[currentQuestionIndex], timeLeft));
    startTimer();
  }

  // This function starts the timer for the quiz
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        timeLeft--;
        emit(QuizQuestionLoaded(questions[currentQuestionIndex], timeLeft));
      } else {
        timer.cancel();
        moveToNextQuestion();
      }
    });
  }

  // This function is called when the user submits an answer
  void submitAnswer(String answer) {
    if (answer == questions[currentQuestionIndex].correctAnswer) {
      score++;
    }
    moveToNextQuestion();
  }

  // Move to the next question
  void moveToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      timeLeft = 60;
      emit(QuizQuestionLoaded(questions[currentQuestionIndex], timeLeft));
    } else {
      emit(QuizCompleted(score, questions.length));
      timer?.cancel();
    }
  }

  // This function is called when the user wants to reset the quiz
  void resetQuiz() {
    currentQuestionIndex = 0;
    score = 0;
    timeLeft = 60;
    emit(QuizInitial());
  }

  // This function is called when the user wants to restart the quiz
  void restartQuiz() {
    resetQuiz();
    startQuiz();
  }

  // This function is called when the user wants to stop the quiz
  void stopQuiz() {
    timer?.cancel();
    emit(QuizInitial());
  }

  // This function is called when the user wants to pause or resume the quiz
  void resumeQuiz() {
    startTimer();
    emit(QuizQuestionLoaded(questions[currentQuestionIndex], timeLeft));
  }

  // This function is called when the user wants to pause the quiz
  void pauseQuiz() {
    timer?.cancel();
    emit(QuizQuestionLoaded(questions[currentQuestionIndex], timeLeft));
  }

  // This function is called when the user wants to skip the current question
  void skipQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      timeLeft = 60;
      emit(QuizQuestionLoaded(questions[currentQuestionIndex], timeLeft));
    } else {
      emit(QuizCompleted(score, questions.length));
      timer?.cancel();
    }
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
