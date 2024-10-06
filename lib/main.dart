import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flashcard_quiz_app/screens/home_screen.dart';
import 'package:flashcard_quiz_app/models/flashcard_provider.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const FlashcardApp());
}

class FlashcardApp extends StatelessWidget {
  const FlashcardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FlashcardProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          textTheme: GoogleFonts.latoTextTheme(),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}