// lib/data/questions.dart

import 'package:quiz_app/models/question_model.dart';

final List<QuestionModel> questions = [
  QuestionModel(
    id: 1,
    question: "ما هي عاصمة فرنسا ؟",
    // question: "What is the capital of France?",
    answers: ["برلين", "مدريد", "باريس"],
    correctAnswer: "باريس",
  ),
  QuestionModel(
    id: 2,
    question: "ما هي نتيجة 2 + 2",
    // question: "What is the result of 2 + 2?",
    answers: ["3", "4", "5"],
    correctAnswer: "4",
  ),
  QuestionModel(
    id: 3,
    question: "ما هو الكوكب المعروف بالكوكب الأحمر ؟",
    // question: "What is the planet known as the red planet?",
    answers: ["مارس", "جوبيتر", "فينوس"],
    correctAnswer: "مارس",
  ),
  QuestionModel(
    id: 4,
    question: " من كتب مسرحية هاملت ؟",
    // question: "Who wrote the play Hamlet?",
    answers: ["شارلز جيكنز", "ويليام شكسبير", "ليو تولستوي"],
    correctAnswer: "ويليام شكسبير",
  ),
  QuestionModel(
    id: 5,
    question: "ما هو أكبر محيط في العالم ؟",
    // question: "What is the largest ocean in the world?",
    answers: ["الاطلسي", "الهندي", "الهادي"],
    correctAnswer: "الهادي",
  ),
];
