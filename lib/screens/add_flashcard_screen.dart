import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/flashcard_provider.dart';

class AddFlashcardScreen extends StatefulWidget {
  const AddFlashcardScreen({Key? key}) : super(key: key);

  @override
  _AddFlashcardScreenState createState() => _AddFlashcardScreenState();
}

class _AddFlashcardScreenState extends State<AddFlashcardScreen> {
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();
  final _choiceControllers = List<TextEditingController>.generate(4, (_) => TextEditingController());

  bool isMCQ = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Flashcard"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Question TextField
            TextField(
              controller: _questionController,
              decoration: InputDecoration(
                labelText: "Question",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            const SizedBox(height: 20),

            // Toggle for MCQ
            Row(
              children: [
                Switch(
                  value: isMCQ,
                  onChanged: (value) {
                    setState(() {
                      isMCQ = value;
                    });
                  },
                ),
                const Text("Is this an MCQ?")
              ],
            ),

            // If MCQ, display multiple choice fields
            if (isMCQ) ..._buildMCQFields(),

            // Answer TextField
            TextField(
              controller: _answerController,
              decoration: InputDecoration(
                labelText: "Correct Answer",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            const SizedBox(height: 20),

            // Submit Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                if (_questionController.text.isNotEmpty && _answerController.text.isNotEmpty) {
                  final choices = isMCQ
                      ? _choiceControllers.map((c) => c.text).where((text) => text.isNotEmpty).toList()
                      : null;

                  Provider.of<FlashcardProvider>(context, listen: false).addFlashcard(
                    _questionController.text,
                    _answerController.text,
                    choices: choices,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text("Add Flashcard"),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMCQFields() {
    return [
      const Text("Multiple Choices:"),
      for (int i = 0; i < 4; i++)
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: TextField(
            controller: _choiceControllers[i],
            decoration: InputDecoration(
              labelText: "Choice ${i + 1}",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
        ),
    ];
  }
}
