import 'package:flutter/material.dart';
import 'PlayerCricket.dart';

class TablePlayerListItemCricket extends StatelessWidget {

  TablePlayerListItemCricket({this.tableScore, this.players, this.isCurrentPlayer});

  final Map<int, int> tableScore;
  final List<PlayerCricket> players;
  bool isCurrentPlayer;

  /* method calls to give a color to the number in links with the game */
  Color _getColor(int number) {
    if(_numberIsClose(number)) {
      return Colors.black26;
    }
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
    for(PlayerCricket player in players) {
      if(player.tableCricket[number] < 3) {
        return false;
      }
    }
    return isClose;
  }

  /* method calls to verify if at least one player close the number */
  bool _numberAtLeastOneClose(int number) {
    bool isClose = false;
    for(PlayerCricket player in players) {
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