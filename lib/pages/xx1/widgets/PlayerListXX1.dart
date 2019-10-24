import 'package:flutter/material.dart';
import 'PlayerListXX1Item.dart';
import 'package:dartagnan/common/Player.dart';

typedef void UpdateUserCallback(Player player);


/* widget list to display the different players during the game */
class PlayerListXX1 extends StatefulWidget {
  PlayerListXX1({Key key, this.players, this.currentPlayer, this.onUpdatePlayer,}) : super(key: key);

  final List<Player> players;
  final Player currentPlayer;
  final UpdateUserCallback onUpdatePlayer;

  @override
  _PlayerListXX1State createState() => _PlayerListXX1State();
}

class _PlayerListXX1State extends State<PlayerListXX1> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:500,
      width: 800,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 8.0),
        scrollDirection: Axis.vertical,
        children: widget.players.map((Player player) {
          return PlayerListXX1Item(
            player: player,
            currentPlayer: widget.currentPlayer,
            onUpdatePlayer: widget.onUpdatePlayer,
          );
        }).toList(),
      ),
    );
  }
}