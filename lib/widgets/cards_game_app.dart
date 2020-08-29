import 'package:cards_game/models/battlefield.dart';
import 'package:cards_game/models/player.dart';
import 'package:cards_game/widgets/match_screen.dart';
import 'package:flutter/material.dart';

class CardsGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MatchScreen(
          battlefield: battlefield(),
        ),
      ),
    );
  }

  Battlefield battlefield() {
    final Battlefield battlefield = Battlefield(6, 8);
    battlefield.addPlayer(Player(
      id: 1,
      color: Colors.blue,
      commandPoints: Player.INITIAL_CP,
      health: Player.INITIAL_HEALTH,
    ));
    battlefield.addPlayer(Player(
      id: 2,
      color: Colors.red,
      commandPoints: Player.INITIAL_CP,
      health: Player.INITIAL_HEALTH,
    ));

    return battlefield;
  }
}
