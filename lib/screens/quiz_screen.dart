import 'package:flutter/material.dart';
import '../theme.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What programming language is Flutter built with?',
      'options': ['Java', 'Dart', 'JavaScript', 'Python'],
      'correctAnswer': 1,
      'selectedAnswer': -1,
    },
    {
      'question': 'Which of the following is NOT a Flutter widget?',
      'options': ['Container', 'Column', 'Fragment', 'Text'],
      'correctAnswer': 2,
      'selectedAnswer': -1,
    },
    {
      'question': 'What is the Flutter\'s architecture based on?',
      'options': ['MVC', 'MVVM', 'Reactive', 'Imperative'],
      'correctAnswer': 2,
      'selectedAnswer': -1,
    },
  ];

  int _currentQuestionIndex = 0;

  void _selectAnswer(int answerIndex) {
    setState(() {
      _questions[_currentQuestionIndex]['selectedAnswer'] = answerIndex;
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      }
    });
  }

  void _previousQuestion() {
    setState(() {
      if (_currentQuestionIndex > 0) {
        _currentQuestionIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final options = currentQuestion['options'] as List<String>;
    final selectedAnswer = currentQuestion['selectedAnswer'] as int;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        backgroundColor: AppTheme.quizColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
              style: AppTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  currentQuestion['question'] as String,
                  style: AppTheme.headlineMedium,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    color: selectedAnswer == index
                        ? AppTheme.quizColor.withOpacity(0.1)
                        : AppTheme.surfaceColor,
                    child: ListTile(
                      leading: Radio<int>(
                        value: index,
                        groupValue: selectedAnswer,
                        onChanged: (value) => _selectAnswer(value!),
                        activeColor: AppTheme.quizColor,
                      ),
                      title: Text(options[index]),
                      onTap: () => _selectAnswer(index),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _currentQuestionIndex > 0 ? _previousQuestion : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.quizColor,
                  ),
                  child: const Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: _currentQuestionIndex < _questions.length - 1 ? _nextQuestion : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.quizColor,
                  ),
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
