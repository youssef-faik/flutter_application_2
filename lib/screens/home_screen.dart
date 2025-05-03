import 'package:flutter/material.dart';
import '../theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DorossAI - Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Navigate back to login screen
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to DorossAI!',
              style: AppTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            const Text(
              'Your personal educational assistant',
              style: AppTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildFeatureCard(
                    context,
                    'Generate Flashcards',
                    Icons.card_membership,
                    AppTheme.flashcardColor,
                    () => Navigator.pushNamed(context, '/flashcards'),
                  ),
                  _buildFeatureCard(
                    context,
                    'Generate Quiz',
                    Icons.quiz,
                    AppTheme.quizColor,
                    () => Navigator.pushNamed(context, '/quiz'),
                  ),
                  _buildFeatureCard(
                    context,
                    'Summarize Text',
                    Icons.summarize,
                    AppTheme.summarizeColor,
                    () => Navigator.pushNamed(context, '/summarize'),
                  ),
                  _buildFeatureCard(
                    context,
                    'Extract Key Points',
                    Icons.lightbulb,
                    AppTheme.keyPointsColor,
                    () => Navigator.pushNamed(context, '/key_points'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: color,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: AppTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
