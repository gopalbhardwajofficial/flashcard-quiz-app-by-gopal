import 'package:flashcard_quiz_app/models/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flashcard_quiz_app/screens/add_flashcard_screen.dart';
import 'package:flashcard_quiz_app/models/quiz_screen.dart';
import 'package:flashcard_quiz_app/models/flashcard_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flashcardProvider = Provider.of<FlashcardProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flashcard Quiz"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddFlashcardScreen()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (flashcardProvider.flashcards.isEmpty)
              const Text("No flashcards yet. Add some!"),
            Expanded(
              child: ListView.builder(
                itemCount: flashcardProvider.flashcards.length,
                itemBuilder: (context, index) {
                  final flashcard = flashcardProvider.flashcards[index];
                  return Card(
                    child: ListTile(
                      title: Text(flashcard.question),
                      subtitle: Text(flashcard.answer),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          flashcardProvider.removeFlashcard(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            if (flashcardProvider.flashcards.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const QuizScreen()));
                },
                child: const Text("Start Quiz"),
              ),
          ],
        ),
      ),
    );
  }
}
