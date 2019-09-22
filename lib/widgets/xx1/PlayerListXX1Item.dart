import 'package:flutter/material.dart';
import 'PlayerXX1.dart';
import 'package:flutter_dart_score/pages/common/CommonColors.dart';

typedef void UpdateUserCallback(PlayerXX1 player);

/* Widget to display the detail of a player during the game */
class PlayerListXX1Item extends StatelessWidget {
  PlayerListXX1Item({PlayerXX1 player, this.currentPlayer, this.onUpdatePlayer})
      : player = player,
        super(key: ObjectKey(player));

  final PlayerXX1 player;
  final PlayerXX1 currentPlayer;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 6,
                  child: Text(player.score.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      fontSize: 30,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(player.firstDart != null ? player.firstDart.toString() : '-',
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Roboto',
                              letterSpacing: 0.5,
                              fontSize: 15,
                            ),
                          ),
                          Text(player.secondDart != null ? player.secondDart.toString() : '-',
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Roboto',
                              letterSpacing: 0.5,
                              fontSize: 15,
                            ),
                          ),
                          Text(player.thirdDart != null ? player.thirdDart.toString() : '-',
                            style: TextStyle(
                              color: Colors.grey,
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
                  flex: 4,
                  child: Text(((player.firstDart != null ? player.firstDart : 0) + (player.secondDart != null ? player.secondDart : 0) + (player.thirdDart != null ? player.thirdDart : 0)).toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text('Θ : ' + player.average.toStringAsFixed(2),
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      fontSize: 15,
                    ),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}