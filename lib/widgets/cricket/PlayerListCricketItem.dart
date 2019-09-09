import 'package:flutter/material.dart';
import 'PlayerCricket.dart';
import 'TablePlayerListItemCricket.dart';

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
      return Colors.black45;
    }
    return Colors.black;
  }


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(player.name[0],
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      title: Container(
        decoration: BoxDecoration(
          color: currentPlayer.name == player.name ? Colors.black45 : Colors.white,
          borderRadius: BorderRadius.circular(9.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text(player.score.toString(),
                style: TextStyle(
                  color: currentPlayer.name == player.name ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                  fontSize: 30,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(player.name,
                style: TextStyle(
                  color: currentPlayer.name == player.name ? Colors.white : Colors.black,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                  fontSize: 15,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(player.firstDart != null ? player.firstDart.toString() : '-',
                        style: TextStyle(
                          color: currentPlayer.name == player.name ? Colors.white70 : Colors.grey,
                          fontFamily: 'Roboto',
                          letterSpacing: 0.5,
                          fontSize: 15,
                        ),
                      ),
                      Text(player.secondDart != null ? player.secondDart.toString() : '-',
                        style: TextStyle(
                          color: currentPlayer.name == player.name ? Colors.white70 : Colors.grey,
                          fontFamily: 'Roboto',
                          letterSpacing: 0.5,
                          fontSize: 15,
                        ),
                      ),
                      Text(player.thirdDart != null ? player.thirdDart.toString() : '-',
                        style: TextStyle(
                          color: currentPlayer.name == player.name ? Colors.white70 : Colors.grey,
                          fontFamily: 'Roboto',
                          letterSpacing: 0.5,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: TablePlayerListItemCricket(tableScore: player.tableCricket, players: this.players, isCurrentPlayer: currentPlayer.name == player.name,),
            )
          ],
        ),
      ),
    );
  }
}