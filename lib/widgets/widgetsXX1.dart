import 'package:flutter/material.dart';
import 'package:flutter_dart_score/widgets/widgets.dart';

/* Widget to display the detail of a player during the game */
class PlayerListXX1Item extends StatelessWidget {
  PlayerListXX1Item({Player player, this.currentPlayer, this.onUpdatePlayer})
      : player = player,
        super(key: ObjectKey(player));

  final Player player;
  final Player currentPlayer;
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
            SizedBox(
              width: 70,
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
            SizedBox(
              width: 50,
              child: Text(player.name,
                style: TextStyle(
                  color: currentPlayer.name == player.name ? Colors.white : Colors.black,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              width: 20,
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
            SizedBox(
              width: 30,
              child: Text(((player.firstDart != null ? player.firstDart : 0) + (player.secondDart != null ? player.secondDart : 0) + (player.thirdDart != null ? player.thirdDart : 0)).toString(),
                style: TextStyle(
                  color: currentPlayer.name == player.name ? Colors.white : Colors.black,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              width: 80,
              child: Text('Θ : ' + player.average.toStringAsFixed(2),
              style: TextStyle(
                color: currentPlayer.name == player.name ? Colors.white : Colors.black,
                fontFamily: 'Roboto',
                letterSpacing: 0.5,
                fontSize: 15,
              ),),
            ),
          ],
        ),
      ),
    );
  }
}

/* widget list to display the different players during the game */
class PlayerListXX1 extends StatefulWidget {
  PlayerListXX1({Key key, this.players, this.currentPlayer, this.onUpdatePlayer,}) : super(key: key);

  final List<Player> players;
  final Player currentPlayer;
  final UpdateUserCallback onUpdatePlayer;

  @override
  _PlayerListXX1State createState() => _PlayerListXX1State();
}

class _PlayerListXX1State extends State<PlayerListXX1> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      scrollDirection: Axis.vertical,
      children: widget.players.map((Player player) {
        return PlayerListXX1Item(
          player: player,
          currentPlayer: widget.currentPlayer,
          onUpdatePlayer: widget.onUpdatePlayer,
        );
      }).toList(),
    );
  }
}

/* widget which contains buttons for give dart score for XX1 game */
class ScoringXX1 extends StatelessWidget {

  ScoringXX1({this.currentPlayer, this.multiply = 1, this.onUpdateMultiply, this.onUpdatePlayer});

  final Player currentPlayer;
  final UpdateUserCallback onUpdatePlayer;
  final int multiply;
  final UpdateMultiplyCallback onUpdateMultiply;

  /* method call by backward button to return to the back dart */
  void _handleTapBack() {
    if(currentPlayer.firstDart == null) {
      currentPlayer.backward = true;
    }
    else if(currentPlayer.secondDart == null) {
      currentPlayer.score = currentPlayer.score + currentPlayer.firstDart;
      currentPlayer.backward = false;
      currentPlayer.firstDart = null;
    }
    else if(currentPlayer.thirdDart == null) {
      currentPlayer.score = currentPlayer.score + currentPlayer.secondDart;
      currentPlayer.backward = false;
      currentPlayer.secondDart = null;
    }
    else {
      currentPlayer.score = currentPlayer.score + currentPlayer.thirdDart;
      currentPlayer.backward = false;
      currentPlayer.thirdDart = null;
    }
    onUpdatePlayer(currentPlayer);
  }

  /* method call by multiply button to multiply next dart */
  void _handleTapMultiply(int value) {
    this.onUpdateMultiply(value);
  }

  /* method call by score button to give a score to a dart */
  void _handleTap(int value) {
    currentPlayer.backward = false;
    if(currentPlayer.firstDart == null) {
      currentPlayer.firstDart = value * multiply;
      currentPlayer.score = currentPlayer.score - currentPlayer.firstDart;
      onUpdateMultiply(1);
    }
    else if(currentPlayer.secondDart == null) {
      currentPlayer.secondDart = value * multiply;
      currentPlayer.score = currentPlayer.score - currentPlayer.secondDart;
      onUpdateMultiply(1);
    }
    else if(currentPlayer.thirdDart == null) {
      currentPlayer.thirdDart = value * multiply;
      currentPlayer.score = currentPlayer.score - currentPlayer.thirdDart;
      onUpdateMultiply(1);
    }
    onUpdatePlayer(currentPlayer);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Expanded(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: "btn1",
                    tooltip: 'Add',
                    child: Text('1'),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      _handleTap(1);
                    },
                  ),
                ),
            ),
            Expanded(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: "btn2",
                    tooltip: 'Add',
                    child: Text('2'),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      _handleTap(2);
                    },
                  ),
                ),
            ),
            Expanded(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: "btn3",
                    tooltip: 'Add',
                    child: Text('3'),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      _handleTap(3);
                    },
                  ),
                ),
            ),
            Expanded(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: "btn4",
                    tooltip: 'Add',
                    child: Text('4'),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      _handleTap(4);
                    },
                  ),
                ),
            ),
            Expanded(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: "btn5",
                    tooltip: 'Add',
                    child: Text('5'),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      _handleTap(5);
                    },
                  ),
                ),
            ),
            Expanded(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: "btn6",
                    tooltip: 'Add',
                    child: Text('6'),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      _handleTap(6);
                    },
                  ),
                ),
            ),
            Expanded(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: "btn7",
                    tooltip: 'Add',
                    child: Text('7'),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      _handleTap(7);
                    },
                  ),
                ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: "btn8",
                    tooltip: 'Add',
                    child: Text('8'),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      _handleTap(8);
                    },
                  ),
                ),
            ),
            Expanded(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: "btn9",
                    tooltip: 'Add',
                    child: Text('9'),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      _handleTap(9);
                    },
                  ),
                ),
            ),
            Expanded(
                child:  SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: "btn10",
                    tooltip: 'Add',
                    child: Text('10'),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      _handleTap(10);
                    },
                  ),
                ),
            ),
            Expanded(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: "btn11",
                    tooltip: 'Add',
                    child: Text('11'),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      _handleTap(11);
                    },
                  ),
                ),
            ),
            Expanded(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: "btn12",
                    tooltip: 'Add',
                    child: Text('12'),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      _handleTap(12);
                    },
                  ),
                ),
            ),
            Expanded(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: "btn13",
                    tooltip: 'Add',
                    child: Text('13'),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      _handleTap(13);
                    },
                  ),
                ),
            ),
            Expanded(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: "btn14",
                    tooltip: 'Add',
                    child: Text('14'),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      _handleTap(14);
                    },
                  ),
                ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                width: 50,
                height: 50,
                child: FloatingActionButton(
                  heroTag: "btn15",
                  tooltip: 'Add',
                  child: Text('15'),
                  backgroundColor: Colors.black,
                  onPressed: () {
                    _handleTap(15);
                  },
                ),
              ),
            ),
            Expanded(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: "btn16",
                    tooltip: 'Add',
                    child: Text('16'),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      _handleTap(16);
                    },
                  ),
                ),
            ),
            Expanded(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: "btn17",
                    tooltip: 'Add',
                    child: Text('17'),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      _handleTap(17);
                    },
                  ),
                ),
            ),
            Expanded(
                child:SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: "btn18",
                    tooltip: 'Add',
                    child: Text('18'),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      _handleTap(18);
                    },
                  ),
                ),
            ),
            Expanded(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: "btn19",
                    tooltip: 'Add',
                    child: Text('19'),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      _handleTap(19);
                    },
                  ),
                ),
            ),
            Expanded(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: "btn20",
                    tooltip: 'Add',
                    child: Text('20'),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      _handleTap(20);
                    },
                  ),
                ),
            ),
            Expanded(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: "btn25",
                    tooltip: 'Add',
                    child: Text('25'),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      if(multiply != 3) {
                        _handleTap(25);
                      }
                    },
                  ),
                ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                width: 50,
                height: 50,
                child: FloatingActionButton(
                  heroTag: "btn0",
                  tooltip: 'Add',
                  child: Text('0'),
                  backgroundColor: Colors.black,
                  onPressed: () {
                    _handleTap(0);
                  },
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 50,
                height: 50,
                child: FloatingActionButton(
                  heroTag: "btnX1",
                  tooltip: 'Add',
                  child: Text('X1'),
                  backgroundColor: multiply == 1 ? Colors.black45 : Colors.black12,
                  onPressed: () {
                    _handleTapMultiply(1);
                  },
                ),
              ),
            ),
            Expanded(
            child: SizedBox(
              width: 50,
              height: 50,
              child: FloatingActionButton(
                heroTag: "btnX2",
                tooltip: 'Add',
                child: Text('X2'),
                backgroundColor: multiply == 2 ? Colors.black45 : Colors.black12,
                onPressed: () {
                  _handleTapMultiply(2);
                },
              ),
            ),
            ),
            Expanded(
            child: SizedBox(
                width: 50,
                height: 50,
                child: FloatingActionButton(
                  heroTag: "btnX3",
                  tooltip: 'Add',
                  child: Text('X3'),
                  backgroundColor: multiply == 3 ? Colors.black45 : Colors.black12,
                  onPressed: () {
                    _handleTapMultiply(3);
                  },
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 50,
                height: 50,
                child: FloatingActionButton(
                  heroTag: "btnBack",
                  tooltip: 'Add',
                  child: Text('Back'),
                  backgroundColor: Colors.red,
                  onPressed: _handleTapBack,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}