import 'package:flutter/material.dart';
import 'package:flutter_dart_score/widgets/widgets.dart';

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

class TablePlayerListItemCricket extends StatelessWidget {

  TablePlayerListItemCricket({this.tableScore, this.players, this.isCurrentPlayer});

  final Map<int, int> tableScore;
  final List<Player> players;
  bool isCurrentPlayer;

  /* method calls to give a color to the number in links with the game */
  Color _getColor(int number) {
    if(tableScore[number] == 3 && !_numberIsClose(number)) {
      return Colors.green;
    }
    if(tableScore[number] < 3 && _numberAtLeastOneClose(number)) {
      return Colors.red;
    }
    return Colors.black;
  }

  /* method calls to verify if the number is closed or not */
  bool _numberIsClose(int number) {
    bool isClose = true;
    for(Player player in players) {
      if(player.tableCricket[number] < 3) {
        return false;
      }
    }
    return isClose;
  }

  /* method calls to verify if at least one player close the number */
  bool _numberAtLeastOneClose(int number) {
    bool isClose = false;
    for(Player player in players) {
      if(player.tableCricket[number] == 3) {
        return true;
      }
    }
    return isClose;
  }



  @override
  Widget build(BuildContext context) {
        return Table(
            border: TableBorder.all(width: 0.0, color: Colors.black45, style: BorderStyle.none),
            textBaseline: TextBaseline.ideographic,
          children: [
            TableRow(
              decoration: BoxDecoration(
              ),
              children: [
                TableCell(
                  child: Text('15',
                    style: TextStyle(
                      color: isCurrentPlayer ? Colors.white : Colors.black,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      fontSize: 15,
                    ),
                  ),
                ),
                TableCell(
                  child: Text('16',
                    style: TextStyle(
                      color: isCurrentPlayer ? Colors.white : Colors.black,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      fontSize: 15,
                    ),
                  ),
                ),
                TableCell(
                  child: Text('17',
                    style: TextStyle(
                      color: isCurrentPlayer ? Colors.white : Colors.black,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      fontSize: 15,
                    ),
                  ),
                ),
                TableCell(
                  child: Text('18',
                    style: TextStyle(
                      color: isCurrentPlayer ? Colors.white : Colors.black,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      fontSize: 15,
                    ),
                  ),
                ),
                TableCell(
                  child: Text('19',
                    style: TextStyle(
                      color: isCurrentPlayer ? Colors.white : Colors.black,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      fontSize: 15,
                    ),
                  ),
                ),
                TableCell(
                  child: Text('20',
                    style: TextStyle(
                      color: isCurrentPlayer ? Colors.white : Colors.black,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      fontSize: 15,
                    ),
                  ),
                ),
                TableCell(
                  child: Text('B',
                    style: TextStyle(
                      color: isCurrentPlayer ? Colors.white : Colors.black,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            TableRow(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              children: [
                TableCell(
                  child: Text(tableScore[15].toString(),
                    style: TextStyle(
                      color: _getColor(15),
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      fontSize: 15,
                    ),
                  ),
                ),
                TableCell(
                  child: Text(tableScore[16].toString(),
                    style: TextStyle(
                      color: _getColor(16),
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      fontSize: 15,
                    ),
                  ),
                ),
                TableCell(
                  child: Text(tableScore[17].toString(),
                    style: TextStyle(
                      color: _getColor(17),
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      fontSize: 15,
                    ),
                  ),
                ),
                TableCell(
                  child: Text(tableScore[18].toString(),
                    style: TextStyle(
                      color: _getColor(18),
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      fontSize: 15,
                    ),
                  ),
                ),
                TableCell(
                  child: Text(tableScore[19].toString(),
                    style: TextStyle(
                      color: _getColor(19),
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      fontSize: 15,
                    ),
                  ),
                ),
                TableCell(
                  child: Text(tableScore[20].toString(),
                    style: TextStyle(
                        color: _getColor(20),
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      fontSize: 15,
                    ),
                  ),
                ),
                TableCell(
                  child: Text(tableScore[25].toString(),
                    style: TextStyle(
                      color: _getColor(25),
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      fontSize: 15,
                    ),
                  ),
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
          players: widget.players,
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
    currentPlayer.backward = true;
    onUpdatePlayer(currentPlayer);
  }

  /* method call by multiply button to multiply next dart */
  void _handleTapMultiply(int value) {
    this.onUpdateMultiply(value);
  }

  /* method call by score button to give a score to a dart */
  void _handleTap(int value) {
    _addHistorical();
    if(currentPlayer.firstDart == null) {
      currentPlayer.firstDart = value;
      _updateScore(value);
    }
    else if(currentPlayer.secondDart == null) {
      currentPlayer.secondDart = value;
      _updateScore(value);
    }
    else if(currentPlayer.thirdDart == null) {
      currentPlayer.thirdDart = value;
      _updateScore(value);
    }
  }

  /* method calls to verify if the number is closed or not */
  bool _numberIsClose(int number) {
    bool isClose = true;
    for(Player player in players) {
      if(player.tableCricket[number] < 3) {
        return false;
      }
    }
    return isClose;
  }

  /* methods calls to keep historic for player*/
  void _addHistorical() {
    currentPlayer.backward = false;
    Map<int, int> stateTableCricket = new Map();
    currentPlayer.tableCricket.forEach((key, value) {
      stateTableCricket[key] = value;
    });
    currentPlayer.historical.add(StateHistorical(score: currentPlayer.score, tableCricket: stateTableCricket, firstDart: currentPlayer.firstDart, secondDart: currentPlayer.secondDart, thirdDart: currentPlayer.thirdDart));
  }

  /* methods calls to update score after a dart*/
  void _updateScore(int value) {
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