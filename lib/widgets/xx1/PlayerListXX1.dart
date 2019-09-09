import 'package:flutter/material.dart';
import 'PlayerListXX1Item.dart';
import 'PlayerXX1.dart';

typedef void UpdateUserCallback(PlayerXX1 player);


/* widget list to display the different players during the game */
class PlayerListXX1 extends StatefulWidget {
  PlayerListXX1({Key key, this.players, this.currentPlayer, this.onUpdatePlayer,}) : super(key: key);

  final List<PlayerXX1> players;
  final PlayerXX1 currentPlayer;
  final UpdateUserCallback onUpdatePlayer;

  @override
  _PlayerListXX1State createState() => _PlayerListXX1State();
}

class _PlayerListXX1State extends State<PlayerListXX1> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      scrollDirection: Axis.vertical,
      children: widget.players.map((PlayerXX1 player) {
        return PlayerListXX1Item(
          player: player,
          currentPlayer: widget.currentPlayer,
          onUpdatePlayer: widget.onUpdatePlayer,
        );
      }).toList(),
    );
  }
}