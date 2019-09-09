import 'package:flutter/material.dart';
import 'PlayerCricket.dart';
import 'PlayerListCricketItem.dart';

typedef void UpdateUserCallback(PlayerCricket player);

/* widget list to display the different players during the game */
class PlayerListCricket extends StatefulWidget {
  PlayerListCricket({Key key, this.players, this.currentPlayer, this.onUpdatePlayer,}) : super(key: key);

  final List<PlayerCricket> players;
  final PlayerCricket currentPlayer;
  final UpdateUserCallback onUpdatePlayer;

  @override
  _PlayerListCricketState createState() => _PlayerListCricketState();
}

class _PlayerListCricketState extends State<PlayerListCricket> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      scrollDirection: Axis.vertical,
      children: widget.players.map((PlayerCricket player) {
        return PlayerListCricketItem(
          player: player,
          players: widget.players,
          currentPlayer: widget.currentPlayer,
          onUpdatePlayer: widget.onUpdatePlayer,
        );
      }).toList(),
    );
  }
}