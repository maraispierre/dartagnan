import 'package:flutter/material.dart';
import 'PlayerXX1.dart';

typedef void UpdateUserCallback(PlayerXX1 player);
typedef void UpdateMultiplyCallback(int multiply);

/* widget which contains buttons for give dart score for XX1 game */
class ScoringXX1 extends StatelessWidget {

  ScoringXX1({this.currentPlayer, this.multiply = 1, this.onUpdateMultiply, this.onUpdatePlayer});

  final PlayerXX1 currentPlayer;
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
                    child: Text('1',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5,
                      ),
                    ),
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
                    child: Text('2',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5,
                      ),
                    ),
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
                    child: Text('3',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5,
                      ),
                    ),
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
                    child: Text('4',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5,
                      ),
                    ),
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
                    child: Text('5',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5,
                      ),
                    ),
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
                    child: Text('6',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5,
                      ),
                    ),
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
                    child: Text('7',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5,
                      ),
                    ),
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
                    child: Text('8',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5,
                      ),
                    ),
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
                    child: Text('9',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5,
                      ),
                    ),
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
                    child: Text('10',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5,
                      ),
                    ),
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
                    child: Text('11',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5,
                      ),
                    ),
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
                    child: Text('12',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5,
                      ),
                    ),
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
                    child: Text('13',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5,
                      ),
                    ),
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
                    child: Text('14',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5,
                      ),
                    ),
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
                      fontSize: 19,
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