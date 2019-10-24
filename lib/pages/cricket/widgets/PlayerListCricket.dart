import 'package:flutter/material.dart';
import 'package:dartagnan/common/Player.dart';  
import 'PlayerListCricketItem.dart';

typedef void UpdateUserCallback(Player player);

/* widget list to display the different players during the game */
class PlayerListCricket extends StatefulWidget {
  PlayerListCricket({Key key, this.players, this.currentPlayer, this.onUpdatePlayer,}) : super(key: key);

  final List<Player> players;
  final Player currentPlayer;
  final UpdateUserCallback onUpdatePlayer;

  @override
  _PlayerListCricketState createState() => _PlayerListCricketState();
}

class _PlayerListCricketState extends State<PlayerListCricket> {

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
          return PlayerListCricketItem(
            player: player,
            players: widget.players,
            currentPlayer: widget.currentPlayer,
            onUpdatePlayer: widget.onUpdatePlayer,
          );
        }).toList(),
      )
    );
  }
}