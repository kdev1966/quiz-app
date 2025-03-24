// lib/views/quiz_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/logic/quiz_cubit.dart';
import 'package:quiz_app/logic/quiz_state.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    final quizCubit = context.read<QuizCubit>();
    quizCubit.startQuiz();

    return Scaffold(
      appBar: AppBar(title: Text('تطبيق مسابقة')),
      body: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          if (state is QuizInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is QuizQuestionLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  Image.asset(
                    'assets/images/quiz.png',
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      state.question.question,
                      style: TextStyle(fontSize: 24),
                    ),
                  ),

                  ...state.question.answers.map((answer) {
                    SizedBox(height: 10);
                    return ElevatedButton(
                      onPressed: () => quizCubit.submitAnswer(answer),
                      child: Text(answer),
                    );
                  }),
                  SizedBox(height: 20),
                  Text(
                    'النتيجة: ${quizCubit.score}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text('الوقت المتبقي: ${state.timeLeft}s'),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => quizCubit.skipQuestion(),
                        child: Text('تخطي السؤال'),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () => quizCubit.restartQuiz(),
                        child: Text('اعادة الاختبار'),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () => quizCubit.stopQuiz(),
                        child: Text('إنهاء الاختبار'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (state is QuizCompleted) {
            return Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30),
                  Image.asset(
                    'assets/images/quiz.png',
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '! تم الانتهاء من الاختبار',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Text(
                    //'Score: ${state.score}/${state.totalQuestions}',
                    'النتيجة: ${state.score}/${state.totalQuestions}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    state.score / state.totalQuestions >= 0.8
                        ? 'ممتاز!'
                        : state.score / state.totalQuestions >= 0.5
                        ? 'جيد'
                        : 'يحتاج إلى تحسين',
                    style: TextStyle(fontSize: 24),
                    selectionColor: Colors.green,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      quizCubit.restartQuiz();
                    },
                    child: Text('إعادة تشغيل الاختبار'),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
