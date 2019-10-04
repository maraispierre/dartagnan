import 'package:flutter/material.dart';
import '../Player.dart';
import 'package:dartagnan/common/CommonColors.dart';

typedef void UpdateMultiplyCallback(int multiply);
typedef void RemovePlayerCallback(Player player);

/* Widget to display detail of an adding player */
class AddPlayerListItem extends StatelessWidget {

  AddPlayerListItem({Player player, RemovePlayerCallback removePlayerCallback})
      : player = player,
        onRemovePlayer = removePlayerCallback,
        super(key: ObjectKey(player));

  final Player player;
  final RemovePlayerCallback onRemovePlayer;

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
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                ),
              ),
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