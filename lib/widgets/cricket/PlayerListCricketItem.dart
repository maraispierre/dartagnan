import 'package:flutter/material.dart';
import 'PlayerCricket.dart';
import 'package:dartagnan/widgets/cricket/TablePlayerListItemCricket.dart';
import 'package:dartagnan/pages/common/CommonColors.dart';

typedef void UpdateUserCallback(PlayerCricket player);

/* Widget to display the detail of a player during the game */
class PlayerListCricketItem extends StatelessWidget {
  PlayerListCricketItem({PlayerCricket player, this.currentPlayer, this.players, this.onUpdatePlayer})
      : player = player,
        super(key: ObjectKey(player));

  final PlayerCricket player;
  final PlayerCricket currentPlayer;
  final List<PlayerCricket> players;
  final UpdateUserCallback onUpdatePlayer;

  /* method call to change the color of the current player*/
  Color _getColor(BuildContext context) {
    if(currentPlayer.name == player.name){
      return COLOR_SECONDARY_YELLOW;
    }
    return COLOR_MAIN_BLUE;
  }


  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: currentPlayer.name == player.name ? COLOR_SECONDARY_YELLOW : COLOR_MAIN_BLUE,
          )
        ),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: currentPlayer.name == player.name ? COLOR_SECONDARY_YELLOW : COLOR_MAIN_BLUE,
              ),
              child: Center(
                child: Text(player.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.5,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(player.score.toString()),
            ),
            TablePlayerListItemCricket(tableScore: player.tableCricket, players: players, isCurrentPlayer: player.name == currentPlayer.name ? true : false, smallSize: true,)
          ]
        )
      )
    );
  }
}