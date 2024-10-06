class Flashcard {
  String question;
  String answer;
  List<String>? choices;

  Flashcard({
    required this.question,
    required this.answer,
    this.choices,
  });
}