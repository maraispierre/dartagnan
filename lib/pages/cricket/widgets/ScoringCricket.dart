import 'package:flutter/material.dart';
import 'PlayerCricket.dart';
import 'StateHistorical.dart';
import 'package:dartagnan/common/CommonColors.dart';
import 'package:dartagnan/common/AppLocalizations.dart';

typedef void UpdateUserCallback(PlayerCricket player);
typedef void UpdateMultiplyCallback(int multiply);

/* widget which contains buttons for give dart score for cricket game */
class ScoringCricket extends StatelessWidget {

  ScoringCricket({Key key, this.players, this.currentPlayer, this.multiply = 1, this.onUpdateMultiply, this.onUpdatePlayer}) : super(key: key);

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
    else {
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
                  key: Key('btn15'),
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
                  backgroundColor: COLOR_MAIN_BLUE,
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
                  key: Key('btn16'),
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
                  backgroundColor: COLOR_MAIN_BLUE,
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
                  key: Key('btn17'),
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
                  backgroundColor: COLOR_MAIN_BLUE,
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
                  key: Key('btn18'),
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
                  backgroundColor: COLOR_MAIN_BLUE,
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
                  key: Key('btn19'),
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
                  backgroundColor: COLOR_MAIN_BLUE,
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
                  key: Key('btn20'),
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
                  backgroundColor: COLOR_MAIN_BLUE,
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
                  key: Key('btn25'),
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
                  backgroundColor: COLOR_MAIN_BLUE,
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
                  key: Key('btn0'),
                  heroTag: "btn0",
                  tooltip: 'Add',
                  child: Text('0/' + AppLocalizations.of(context).next,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                    ),
                  ),
                  backgroundColor: COLOR_MAIN_BLUE,
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
                  backgroundColor: multiply == 1 ? Colors.black45 : COLOR_SECONDARY_YELLOW,
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
                  key: Key('btnX2'),
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
                  backgroundColor: multiply == 2 ? Colors.black45 : COLOR_SECONDARY_YELLOW,
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
                  key: Key('btnX3'),
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
                  backgroundColor: multiply == 3 ? Colors.black45 : COLOR_SECONDARY_YELLOW,
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
                  child: Text(AppLocalizations.of(context).back,
                    style: TextStyle(
                      fontSize: 15,
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