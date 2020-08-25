import 'package:cards_game/widgets/match_screen.dart';
import 'package:flutter/material.dart';

class CardsGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: MatchScreen()),
    );
  }
}
