import 'package:flutter/material.dart';
import '../theme.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({Key? key}) : super(key: key);

  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final List<Map<String, String>> _flashcards = [
    {
      'front': 'What is Flutter?',
      'back': 'Flutter is Google\'s UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.'
    },
    {
      'front': 'What is a Widget in Flutter?',
      'back': 'In Flutter, widgets are the basic building blocks of the UI. Everything in Flutter is a widget, from buttons to padding to layouts.'
    },
    {
      'front': 'What is the difference between StatelessWidget and StatefulWidget?',
      'back': 'StatelessWidget is immutable and cannot change its state during the lifetime of the widget. StatefulWidget can change its state multiple times during its lifetime.'
    },
  ];

  int _currentIndex = 0;
  bool _showFront = true;

  void _nextCard() {
    setState(() {
      if (_currentIndex < _flashcards.length - 1) {
        _currentIndex++;
        _showFront = true;
      }
    });
  }

  void _previousCard() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        _showFront = true;
      }
    });
  }

  void _flipCard() {
    setState(() {
      _showFront = !_showFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcards'),
        backgroundColor: AppTheme.flashcardColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Tap on the card to flip it',
              style: AppTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GestureDetector(
                onTap: _flipCard,
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: _showFront ? AppTheme.surfaceColor : AppTheme.flashcardColor.withOpacity(0.1),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        _showFront
                            ? _flashcards[_currentIndex]['front']!
                            : _flashcards[_currentIndex]['back']!,
                        style: _showFront 
                          ? AppTheme.headlineMedium
                          : AppTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _currentIndex > 0 ? _previousCard : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.flashcardColor,
                  ),
                  child: const Text('Previous'),
                ),
                Text(
                  '${_currentIndex + 1}/${_flashcards.length}',
                  style: AppTheme.bodyLarge,
                ),
                ElevatedButton(
                  onPressed: _currentIndex < _flashcards.length - 1 ? _nextCard : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.flashcardColor,
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
