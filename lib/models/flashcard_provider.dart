import 'package:flutter/material.dart';
import 'flashcard.dart';

class FlashcardProvider with ChangeNotifier {
  List<Flashcard> _flashcards = [];

  List<Flashcard> get flashcards => _flashcards;

  void addFlashcard(String question, String answer, {List<String>? choices}) {
    _flashcards.add(Flashcard(question: question, answer: answer, choices: choices));
    notifyListeners();
  }

  void removeFlashcard(int index) {
    _flashcards.removeAt(index);
    notifyListeners();
  }

  void clearFlashcards() {
    _flashcards.clear();
    notifyListeners();
  }
}
