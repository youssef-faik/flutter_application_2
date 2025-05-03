import 'package:flutter/material.dart';
import '../theme.dart';

class KeyPointsScreen extends StatefulWidget {
  const KeyPointsScreen({Key? key}) : super(key: key);

  @override
  _KeyPointsScreenState createState() => _KeyPointsScreenState();
}

class _KeyPointsScreenState extends State<KeyPointsScreen> {
  final TextEditingController _textController = TextEditingController();
  List<String>? _keyPoints;
  bool _isLoading = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _extractKeyPoints() {
    // Check if text is empty
    if (_textController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter some text to extract key points')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call delay
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        // Mock key points - in a real app, these would come from an API
        _keyPoints = [
          'Flutter is a UI toolkit developed by Google for building natively compiled applications for mobile, web, and desktop from a single codebase.',
          'Flutter uses a reactive programming model and a rich set of pre-built widgets to create beautiful and responsive user interfaces.',
          'The hot reload feature in Flutter allows developers to see changes in real-time without losing the application state, making development faster and more efficient.'
        ];
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extract Key Points'),
        backgroundColor: AppTheme.keyPointsColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter text to extract key points:',
              style: AppTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _textController,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: 'Paste your text here...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _extractKeyPoints,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.keyPointsColor,
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Extract Key Points'),
            ),
            const SizedBox(height: 24),
            if (_keyPoints != null) ...[
              const Text(
                'Key Points:',
                style: AppTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.keyPointsColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.keyPointsColor.withOpacity(0.3)),
                  ),
                  child: ListView.builder(
                    itemCount: _keyPoints!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '• ',
                              style: AppTheme.titleLarge,
                            ),
                            Expanded(
                              child: Text(
                                _keyPoints![index],
                                style: AppTheme.bodyLarge,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
