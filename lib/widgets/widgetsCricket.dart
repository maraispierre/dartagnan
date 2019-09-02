import 'package:flutter/material.dart';
import 'package:flutter_dart_score/widgets/widgets.dart';

/* Widget to display the detail of a player during the game */
class PlayerListCricketItem extends StatelessWidget {
  PlayerListCricketItem({Player player, this.currentPlayer, this.onUpdatePlayer})
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
              flex: 6,
              child: TablePlayerListItemCricket(tableScore: player.tableCricket,),
            )
          ],
        ),
      ),
    );
  }
}

class TablePlayerListItemCricket extends StatelessWidget {

  TablePlayerListItemCricket({this.tableScore});

  final Map<int, int> tableScore;

  @override
  Widget build(BuildContext context) {
        return Table(
          border: TableBorder.all(width: 1.0, color: Colors.black,),
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Text('15'),
                ),
                TableCell(
                  child: Text('16'),
                ),
                TableCell(
                  child: Text('17'),
                ),
                TableCell(
                  child: Text('18'),
                ),
                TableCell(
                  child: Text('19'),
                ),
                TableCell(
                  child: Text('20'),
                ),
                TableCell(
                  child: Text('BULL'),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Text(tableScore[15].toString()),
                ),
                TableCell(
                  child: Text(tableScore[16].toString()),
                ),
                TableCell(
                  child: Text(tableScore[17].toString()),
                ),
                TableCell(
                  child: Text(tableScore[18].toString()),
                ),
                TableCell(
                  child: Text(tableScore[19].toString()),
                ),
                TableCell(
                  child: Text(tableScore[20].toString()),
                ),
                TableCell(
                  child: Text(tableScore[25].toString()),
                ),
              ],
            ),
          ],
        );
  }
}

/* widget list to display the different players during the game */
class PlayerListCricket extends StatefulWidget {
  PlayerListCricket({Key key, this.players, this.currentPlayer, this.onUpdatePlayer,}) : super(key: key);

  final List<Player> players;
  final Player currentPlayer;
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
      children: widget.players.map((Player player) {
        return PlayerListCricketItem(
          player: player,
          currentPlayer: widget.currentPlayer,
          onUpdatePlayer: widget.onUpdatePlayer,
        );
      }).toList(),
    );
  }
}

/* widget which contains buttons for give dart score for cricket game */
class ScoringCricket extends StatelessWidget {

  ScoringCricket({this.players, this.currentPlayer, this.multiply = 1, this.onUpdateMultiply, this.onUpdatePlayer});

  final List<Player> players;
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
      currentPlayer.firstDart = value;
      if(value != 0 && currentPlayer.tableCricket[value] < 3) {
        currentPlayer.tableCricket[value] = currentPlayer.tableCricket[value] + multiply * 1;
        if(currentPlayer.tableCricket[value] > 3 && !_numberIsClose(value)) {
          int multiply = 0;
          while(currentPlayer.tableCricket[value] > 3) {
            currentPlayer.tableCricket[value]--;
            multiply++;
          }
          currentPlayer.score = currentPlayer.score + value * multiply;
        }

      }
      else if( value != 0 && !_numberIsClose(value)) {
        currentPlayer.score = currentPlayer.score = currentPlayer.score + multiply * value;
      }
      onUpdateMultiply(1);
      onUpdatePlayer(currentPlayer);
    }
    else if(currentPlayer.secondDart == null) {
      currentPlayer.secondDart = value;
      if(value != 0 && currentPlayer.tableCricket[value] < 3) {
        currentPlayer.tableCricket[value] = currentPlayer.tableCricket[value] + multiply * 1;
        if(currentPlayer.tableCricket[value] > 3) {
          int multiply = 0;
          while(currentPlayer.tableCricket[value] > 3) {
            currentPlayer.tableCricket[value]--;
            multiply++;
          }
          currentPlayer.score = currentPlayer.score + value * multiply;
        }

      }
      else if(value != 0 && !_numberIsClose(value)) {
        currentPlayer.score = currentPlayer.score = currentPlayer.score + multiply * value;
      }
      onUpdateMultiply(1);
      onUpdatePlayer(currentPlayer);
    }
    else if(currentPlayer.thirdDart == null) {
      currentPlayer.thirdDart = value;
      if(value != 0 && currentPlayer.tableCricket[value] < 3) {
        currentPlayer.tableCricket[value] = currentPlayer.tableCricket[value] + multiply * 1;
        if(currentPlayer.tableCricket[value] > 3) {
          int multiply = 0;
          while(currentPlayer.tableCricket[value] > 3) {
            currentPlayer.tableCricket[value]--;
            multiply++;
          }
          currentPlayer.score = currentPlayer.score + value * multiply;
        }

      }
      else if(value != 0 && !_numberIsClose(value)) {
        currentPlayer.score = currentPlayer.score = currentPlayer.score + multiply * value;
      }
      onUpdateMultiply(1);
      onUpdatePlayer(currentPlayer);
    }
  }

  bool _numberIsClose(int number) {
    bool isClose = true;
    for(Player player in players) {
      if(player.tableCricket[number] < 3) {
        return false;
      }
    }
    return isClose;
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