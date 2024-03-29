import 'package:flutter/material.dart';
import 'package:dartagnan/common/Player.dart';
import 'package:dartagnan/common/CommonColors.dart';
import 'package:dartagnan/common/CustomIcons.dart';

typedef void UpdateUserCallback(Player player);

/* Widget to display the detail of a player during the game */
class PlayerListXX1Item extends StatelessWidget {
  PlayerListXX1Item({Player player, this.currentPlayer, this.onUpdatePlayer})
      : player = player,
        super(key: ObjectKey(player));

  final Player player;
  final Player currentPlayer;
  final UpdateUserCallback onUpdatePlayer;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 6,
                  child: Text(player.score.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Portico',
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
                          Row(
                            children: <Widget>[
                              Icon(
                                CustomIcons.first_dart,
                                color: Colors.grey,
                                size: 20.0,
                              ),
                              Text(player.firstDart != null ? player.firstDart.toString() : '-',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Portico',
                                  letterSpacing: 0.5,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                CustomIcons.second_dart,
                                color: Colors.grey,
                                size: 20.0,
                              ),
                              Text(player.secondDart != null ? player.secondDart.toString() : '-',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Portico',
                                  letterSpacing: 0.5,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                CustomIcons.third_dart,
                                color: Colors.grey,
                                size: 20.0  ,
                              ),
                              Text(player.thirdDart != null ? player.thirdDart.toString() : '-',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Portico',
                                  letterSpacing: 0.5,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        CustomIcons.three_darts,
                        size: 20,
                      ),
                      Text(((player.firstDart != null ? player.firstDart : 0) + (player.secondDart != null ? player.secondDart : 0) + (player.thirdDart != null ? player.thirdDart : 0)).toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Portico',
                          letterSpacing: 0.5,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  )
                ),
                Expanded(
                  flex: 6,
                  child: Text('Θ : ' + player.average.toStringAsFixed(2),
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Portico',
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