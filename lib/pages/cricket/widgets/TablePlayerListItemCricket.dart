import 'package:flutter/material.dart';
import 'PlayerCricket.dart';
import 'package:dartagnan/common/CommonColors.dart';

class TablePlayerListItemCricket extends StatelessWidget {

  TablePlayerListItemCricket({this.tableScore, this.players, this.isCurrentPlayer, this.smallSize});

  final Map<int, int> tableScore;
  final List<PlayerCricket> players;
  final bool isCurrentPlayer;
  final bool smallSize;

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
      border: TableBorder.all(width: 1.0, color: isCurrentPlayer ? COLOR_SECONDARY_YELLOW : COLOR_MAIN_BLUE, style: BorderStyle.solid),
      textBaseline: TextBaseline.ideographic,
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: isCurrentPlayer? COLOR_SECONDARY_YELLOW : COLOR_MAIN_BLUE,
          ),
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Center(
                child: Text('15',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Portico',
                    letterSpacing: 0.5,
                    fontSize: smallSize ? 15 : 20,
                  ),
                ),
              )
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                  child: Text('16',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Portico',
                      letterSpacing: 0.5,
                      fontSize: smallSize ? 15 : 20,
                    ),
                  ),
                )
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                  child: Text('17',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Portico',
                      letterSpacing: 0.5,
                      fontSize: smallSize ? 15 : 20,
                    ),
                  ),
                )
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                  child: Text('18',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Portico',
                      letterSpacing: 0.5,
                      fontSize: smallSize ? 15 : 20,
                    ),
                  ),
                )
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                  child: Text('19',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Portico',
                      letterSpacing: 0.5,
                      fontSize: smallSize ? 15 : 20,
                    ),
                  ),
                )
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                  child: Text('20',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Portico',
                      letterSpacing: 0.5,
                      fontSize: smallSize ? 15 : 20,
                    ),
                  ),
                )
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                  child: Text('B',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Portico',
                      letterSpacing: 0.5,
                      fontSize: smallSize ? 15 : 20,
                    ),
                  ),
                )
            ),
          ],
        ),
        TableRow(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Center(
                child: Text(tableScore[15].toString(),
                  style: TextStyle(
                    color: _getColor(15),
                    fontFamily: 'Portico',
                    letterSpacing: 0.5,
                    fontSize: smallSize ? 15 : 20,
                  ),
                ),
              )
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                  child: Text(tableScore[16].toString(),
                    style: TextStyle(
                      color: _getColor(16),
                      fontFamily: 'Portico',
                      letterSpacing: 0.5,
                      fontSize: smallSize ? 15 : 20,
                    ),
                  ),
                )
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                  child: Text(tableScore[17].toString(),
                    style: TextStyle(
                      color: _getColor(17),
                      fontFamily: 'Portico',
                      letterSpacing: 0.5,
                      fontSize: smallSize ? 15 : 20,
                    ),
                  ),
                )
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                  child: Text(tableScore[18].toString(),
                    style: TextStyle(
                      color: _getColor(18),
                      fontFamily: 'Portico',
                      letterSpacing: 0.5,
                      fontSize: smallSize ? 15 : 20,
                    ),
                  ),
                )
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                  child: Text(tableScore[19].toString(),
                    style: TextStyle(
                      color: _getColor(19),
                      fontFamily: 'Portico',
                      letterSpacing: 0.5,
                      fontSize: smallSize ? 15 : 20,
                    ),
                  ),
                )
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                  child: Text(tableScore[20].toString(),
                    style: TextStyle(
                      color: _getColor(20),
                      fontFamily: 'Portico',
                      letterSpacing: 0.5,
                      fontSize: smallSize ? 15 : 20,
                    ),
                  ),
                )
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Center(
                  child: Text(tableScore[25].toString(),
                    style: TextStyle(
                      color: _getColor(25),
                      fontFamily: 'Portico',
                      letterSpacing: 0.5,
                      fontSize: smallSize ? 15 : 20,
                    ),
                  ),
                )
            ),
          ],
        ),
      ],
    );
  }
}