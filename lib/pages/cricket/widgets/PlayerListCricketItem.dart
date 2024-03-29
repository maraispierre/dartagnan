import 'package:flutter/material.dart';
import 'package:dartagnan/common/Player.dart';
import 'package:dartagnan/pages/cricket/widgets/TablePlayerListItemCricket.dart';
import 'package:dartagnan/common/CommonColors.dart';

typedef void UpdateUserCallback(Player player);

/* Widget to display the detail of a player during the game */
class PlayerListCricketItem extends StatelessWidget {
  PlayerListCricketItem({Player player, this.currentPlayer, this.players, this.onUpdatePlayer})
      : player = player,
        super(key: ObjectKey(player));

  final Player player;
  final Player currentPlayer;
  final List<Player> players;
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
                    fontFamily: 'Portico',
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