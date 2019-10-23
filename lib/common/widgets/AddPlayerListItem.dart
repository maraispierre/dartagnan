import 'package:flutter/material.dart';
import '../Player.dart';
import 'package:dartagnan/common/CommonColors.dart';

typedef void UpdateMultiplyCallback(int multiply);
typedef void RemovePlayerCallback(Player player);

/* Widget to display detail of an adding player */
class AddPlayerListItem extends StatelessWidget {

  AddPlayerListItem({Player player, List<Player> players, RemovePlayerCallback removePlayerCallback})
      : player = player,
        players = players,
        onRemovePlayer = removePlayerCallback,
        super(key: ObjectKey(player));

  final Player player;
  final List<Player> players;
  final RemovePlayerCallback onRemovePlayer;

  String giveMedal(Player player) {
    if(player.id == players[0].id) {
      return "assets/medal-first.png";
    }
    if(player.id == players[1].id) {
      return "assets/medal-second.png";
    }
    if(player.id == players[2].id) {
      return "assets/medal-third.png";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          backgroundColor: COLOR_MAIN_BLUE,
          child: Text(player.name[0],
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 100,
              child: Text(player.name,
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            giveMedal(player) != null ?
            Image(image: AssetImage(giveMedal(player)), height: 35.0)
                :
            Text("         "),
            Expanded(
              flex: 2,
              child: Text(player.numberWonGame.toString()),
            ),
            Expanded(
              flex: 2,
              child: Text('Θ : ' + (player.totalScore == 0 ? "0" : (player.totalScore / player.totalRounds).toStringAsFixed(2)))
            ),
            SizedBox(
              width: 35.0,
              height: 35.0,
              child: FloatingActionButton(
                heroTag: "btnRemove" + player.name,
                backgroundColor: Colors.red,
                child: Icon(Icons.remove),
                onPressed: () {
                  onRemovePlayer(player);
                },
              ),
            ),
          ],
        )
    );
  }
}