import 'package:flutter/material.dart';

/* Object Player manipulate on all XX1 game widget */
class Player {
  Player({this.name, this.score, this.tableCricket, this.firstDart, this.secondDart ,this.thirdDart, this.average = 0.0, this.backward = false, this.round = 0, this.totalScore = 0});
  String name;
  int score;
  Map<int, int> tableCricket;
  int firstDart;
  int secondDart;
  int thirdDart;
  double average;
  int round;
  int totalScore;
  bool backward;

}

typedef void UpdateUserCallback(Player player);
typedef void UpdateMultiplyCallback(int multiply);
typedef void RemovePlayerCallback(String namePlayer);

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
          backgroundColor: Colors.black,
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
                  onRemovePlayer(player.name);
                },
              ),
            ),
          ],
        )
    );
  }
}

/* widget which contains message for player */
class MessagePlayer extends StatelessWidget {

  MessagePlayer({this.message, this.helpMessage});

  final String message;
  final String helpMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Center(
        child : Column(
          children: <Widget>[
            Text(message,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                fontFamily: 'Roboto',
                letterSpacing: 0.5,
              ),
            ),
            Text(helpMessage,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white70,
                fontFamily: 'Roboto',
                letterSpacing: 0.5,
              ),
            ),
          ],
        )
      ),
    );
  }
}