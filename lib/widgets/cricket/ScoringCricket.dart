import 'package:flutter/material.dart';
import 'PlayerCricket.dart';
import 'StateHistorical.dart';

typedef void UpdateUserCallback(PlayerCricket player);
typedef void UpdateMultiplyCallback(int multiply);

/* widget which contains buttons for give dart score for cricket game */
class ScoringCricket extends StatelessWidget {

  ScoringCricket({this.players, this.currentPlayer, this.multiply = 1, this.onUpdateMultiply, this.onUpdatePlayer});

  final List<PlayerCricket> players;
  final PlayerCricket currentPlayer;
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
    for(PlayerCricket player in players) {
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
                  child: Text('15',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                    ),
                  ),
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
                  child: Text('16',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                    ),
                  ),
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
                  child: Text('17',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                    ),
                  ),
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
                  child: Text('18',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                    ),
                  ),
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
                  child: Text('19',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                    ),
                  ),
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
                  child: Text('20',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                    ),
                  ),
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
                  child: Text('25',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                    ),
                  ),
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
                  child: Text('0',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                    ),
                  ),
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
                  child: Text('X1',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                    ),
                  ),
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
                  child: Text('X2',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                    ),
                  ),
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
                  child: Text('X3',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                    ),
                  ),
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
                  child: Text('Back',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                    ),
                  ),
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