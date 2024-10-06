import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/flashcard_provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int correctAnswers = 0;
  String selectedAnswer = '';

  @override
  Widget build(BuildContext context) {
    final flashcards = Provider.of<FlashcardProvider>(context).flashcards;

    if (flashcards.isEmpty) {
      return Scaffold(
        body: const Center(child: Text("No flashcards available for quiz.")),
      );
    }

    final flashcard = flashcards[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Card(
                key: ValueKey(flashcard.question),
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        flashcard.question,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),

                      // Display MCQ options if available
                      if (flashcard.choices != null && flashcard.choices!.isNotEmpty)
                        Column(
                          children: flashcard.choices!
                              .map(
                                (choice) => ListTile(
                              title: Text(choice),
                              leading: Radio<String>(
                                value: choice,
                                groupValue: selectedAnswer,
                                onChanged: (value) {
                                  setState(() {
                                    selectedAnswer = value!;
                                  });
                                },
                              ),
                            ),
                          )
                              .toList(),
                        )
                      else
                      // Input answer field for non-MCQ questions
                        TextField(
                          decoration: const InputDecoration(labelText: "Your Answer"),
                          onChanged: (value) {
                            selectedAnswer = value;
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Check if the selected answer is correct
                if (selectedAnswer.trim().toLowerCase() == flashcard.answer.trim().toLowerCase()) {
                  correctAnswers++;
                }
                if (currentIndex < flashcards.length - 1) {
                  setState(() {
                    currentIndex++;
                    selectedAnswer = '';
                  });
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(score: correctAnswers),
                    ),
                  );
                }
              },
              child: const Text("Next Question"),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final int score;

  const ResultScreen({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Quiz Complete!",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              "Your Score: $score",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Go to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
