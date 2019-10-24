import 'package:flutter/material.dart';
import 'package:dartagnan/common/widgets/MessagePlayer.dart';
import 'package:dartagnan/pages/xx1/widgets/ScoringXX1.dart';
import 'package:dartagnan/common/Player.dart';
import 'package:dartagnan/common/CommonColors.dart';
import 'package:dartagnan/pages/xx1/widgets/PlayerXX1Detail.dart';
import 'package:dartagnan/common/AppLocalizations.dart';
import 'package:dartagnan/services/RoomService.dart';
import 'package:dartagnan/common/Room.dart';
import 'package:dartagnan/pages/launcher/GameLauncher.dart';

/* Global Widget Page  which contains :
 * - PlayerList for XX1 (PlayerListXX1)
 * - Current round message for XX1
 * - Scoring buttons for XX1 (ScoringXX1)
 * - Strategy to manage XX1 game
 */

class GameXX1 extends StatefulWidget {
  GameXX1({Key key, this.players, this.endByDouble, this.score, this.room}) : super(key: key);

  final List<Player> players;
  final bool endByDouble;
  final int score;
  final Room room;

  @override
  _GameXX1State createState() => _GameXX1State();
}

/* State form StatefulWidget GameXX1*/
class _GameXX1State extends State<GameXX1> {

  Player _currentPlayer;
  String _helpMessage;
  int _counterPlayer;
  int _multiply;
  bool _changePlayer;
  bool _isEndGame;

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    _currentPlayer = widget.players[0];
    _helpMessage = '';
    _counterPlayer = 0;
    _multiply = 1;
    _changePlayer = true;
    _isEndGame = false;

    for(Player player in widget.players){
      player.resetPlayer(widget.score);
    }
  }

  /* Methods call for update player information after an action. It is the global strategy of XX1 game */
  void _handleUpdateMultiply(int multiply) {
    setState(() {
      _changePlayer = false;
      _multiply = multiply;
    });
  }

  /* Methods call for update player information after an action. It is the global strategy of XX1 game */
  void _handleUpdatePlayer(Player player) {
    setState(() {
      _currentPlayer = player;
      _changePlayer = false;
      _isEndGame = false;
      // Verify if the current player finished the game
      if(_endGame(_currentPlayer)) {
        return;
      }
      // Verify if the currentPlayer take a too biggest score
      else if(_badScore(_currentPlayer)) {
        _generateMessage();
        return;
      }
      // Verify if the user call to back to the previous player
      else if(_backToPreviousPlayer()){
        _generateMessage();
        return;
      }
      // Go to next player when the current player shooted this 3 darts
      else if(_nextPlayer(_currentPlayer)) {
        _generateMessage();
        return;
      }
      _generateMessage();
      _multiply = 1;
    });
  }

  /* method call to verify and process end game if game is over */
  bool _endGame(Player player) {
    if((widget.endByDouble && _multiply == 2 && _currentPlayer.score == 0) || (!widget.endByDouble && _currentPlayer.score == 0)){
      _isEndGame = true;
      _helpMessage = '';

      player.numberWonGame++;
      for(Player player in widget.players){
        player.updateStatsXx1();
        player.resetPlayer(widget.score);
      }
      if(widget.room.id != -1) {
        RoomService().updateRoom(widget.room);
      }
      return true;
    }
    return false;
  }

  /* method call to verify that current player score is less than that zero */
  bool _badScore(Player player) {
    if(player.score < 0) {
      player.score = player.score + (player.firstDart != null ? player.firstDart : 0) + (player.secondDart != null ? player.secondDart : 0) + (player.thirdDart != null ? player.thirdDart : 0);
      if(widget.players.length - 1 == _counterPlayer) {
        _counterPlayer = 0;
        _currentPlayer = widget.players[_counterPlayer];
        _currentPlayer.round++;

      }
      else {
        _counterPlayer++;
        _currentPlayer = widget.players[_counterPlayer];
        _currentPlayer.round++;
      }
      _initRound(_currentPlayer);
      return true;
    }
    return false;
  }

  /* method call to back to the previous player */
  bool _backToPreviousPlayer() {
    if(_currentPlayer.backward && _currentPlayer.round == 0 && (_currentPlayer.name == widget.players[0].name)) {
      _currentPlayer.backward = false;
      _changePlayer = true;
      return true;
    }
    else if(_currentPlayer.backward){
      _currentPlayer.backward = false;
      if(_counterPlayer == 0) {
        _counterPlayer = widget.players.length - 1;
        _currentPlayer = widget.players[_counterPlayer];
      }
      else {
        _counterPlayer--;
        _currentPlayer = widget.players[_counterPlayer];
      }
      _currentPlayer.totalScoreGame = _currentPlayer.totalScoreGame - _currentPlayer.firstDart - _currentPlayer.secondDart - _currentPlayer.thirdDart;
      _currentPlayer.round--;
      _changePlayer = true;
      return true;
    }
    _changePlayer = false;
    return false;
  }

  /* method call to go to next player when the current player shooted this 3 darts */
  bool _nextPlayer(Player player) {
   if(player.thirdDart != null) {
      player.round++;
      player.totalScoreGame = player.totalScoreGame + player.firstDart + player.secondDart + player.thirdDart;
      player.average = player.totalScoreGame / player.round;
      if(widget.players.length - 1 == _counterPlayer) {
        _counterPlayer = 0;
        _currentPlayer = widget.players[_counterPlayer];
      }
      else {
        _counterPlayer++;
        _currentPlayer = widget.players[_counterPlayer];
      }
      _initRound(_currentPlayer);
      return true;
    }
    _changePlayer = false;
    return false;
  }

  /* method call to init round before each next round */
  void _initRound(Player player) {
    player.firstDart = null;
    player.secondDart = null;
    player.thirdDart = null;
    _changePlayer = true;
    _multiply = 1;
  }

  /* method calls to display message after each dart of a player */
  void _generateMessage() {
    _generateHelpMessage();
  }

  /* method calls to display a help message to a player when it can end game */
  void _generateHelpMessage() {
    _helpMessage = '';
    int nbRemainingDart = _getNumberRemainingDart();
    int nbNecessaryDart = _getNumberNecessaryDart();
    if(nbNecessaryDart <= 3 && nbRemainingDart>= nbNecessaryDart) {
      String lastDart = _getLastDart(_currentPlayer.score);
      if(nbNecessaryDart == 3 && lastDart != null) {
        _helpMessage = '3X20 3X20 ' + lastDart;
      }
      else if(nbNecessaryDart == 3) {
        int remaining = _currentPlayer.score - 60;
        for(int i = 1; i < 4; i++) {
          for(int j = 1; j < 21; j++) {
            String trueLastDart = _getLastDart(remaining - i * j);
            if( trueLastDart != null) {
              _helpMessage = '3X20 '+ i.toString() + 'X' + j.toString() + ' '+ trueLastDart;
            }
          }
        }
      }
      else if(nbNecessaryDart == 2 && lastDart != null) {
        _helpMessage = '3X20 ' + lastDart;
      }
      else if(nbNecessaryDart == 2) {
        int remaining = _currentPlayer.score;
        for(int i = 1; i < 4; i++) {
          for(int j = 1; j < 21; j++) {
            String trueLastDart = _getLastDart(remaining - i * j);
            if( trueLastDart != null) {
              _helpMessage =   i.toString() + 'X' + j.toString() + ' '+ trueLastDart;
            }
          }
        }
        if(_helpMessage == '' && nbRemainingDart == 3) {
          for(int m = 1; m < 4; m++){
            for(int n = 1; n < 21; n++) {
              for(int i = 1; i < 4; i++) {
                for(int j = 1; j < 21; j++) {
                  String trueLastDart = _getLastDart(remaining - (i * j) - (m * n));
                  if( trueLastDart != null) {
                    _helpMessage =   m.toString() + 'X' + n.toString() + ' ' + i.toString() + 'X' + j.toString() + ' ' + trueLastDart;
                  }
                }
              }
            }
          }
        }
      }
      else if(nbNecessaryDart == 1 && lastDart != null){
        _helpMessage =  lastDart;
      }
      else if(nbNecessaryDart == 1 && nbRemainingDart >= 2) {
        int remaining = _currentPlayer.score;
        for(int i = 1; i < 4; i++) {
          for(int j = 1; j < 21; j++) {
            String trueLastDart = _getLastDart(remaining - i * j);
            if( trueLastDart != null) {
              _helpMessage =   i.toString() + 'X' + j.toString() + ' '+ trueLastDart;
            }
          }
        }
      }
      else {
        _helpMessage = '';
      }
    }
    else {
      _helpMessage = '';
    }
  }

  /* method call to return the last dart to finish or null if it doesn't possible */
  String _getLastDart(int score){
    int remaining = score;
    if(widget.endByDouble) {
      for(int j = 1; j < 21; j++) {
        if(remaining - 2 * j == 0) {
          return '2X' + j.toString();
        }
      }
      if(remaining - 2 * 25 == 0) {
        return '2X25';
      }
      return null;
    }
    else {
      for(int i = 1; i < 4; i++) {
        for(int j = 1; j < 21; j++) {
          if(remaining - i * j == 0) {
            return i.toString() + 'X' + j.toString();
          }
        }
        if(remaining - i * 25 == 0) {
          return  i.toString() + 'X25';
        }
      }
      return null;
    }
  }

  /* method calls to have the number of remaining dart of the current player */
  int _getNumberRemainingDart() {
    if(_currentPlayer.firstDart == null) {
      return 3;
    }
    else if(_currentPlayer.secondDart == null) {
      return 2;
    }
    return 1;
  }

  /* method calls to have the number of necessary dart to end the game */
  int _getNumberNecessaryDart() {
    double result = _currentPlayer.score / 60;
    if(result > 3) {
      return 4;
    }
    else if(result > 2 && result <= 3) {
      return 3;
    }
    else if(result > 1 && result <= 2) {
      return 2;
    }
    else if(result > 0 && result <= 1){
      return 1;
    }
    return 4;
  }

  // method calls o alert user when it quit the game
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(AppLocalizations.of(context).warning,
            style: TextStyle(
                color: COLOR_SECONDARY_YELLOW
            ),
          ),
          content: new Text(AppLocalizations.of(context).messageLeave,
            style: TextStyle(
              fontSize: 12
            )
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text(AppLocalizations.of(context).yes),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return GameLauncher();
                    },
                  ),
                );
              },
            ),
            FlatButton(
              child: new Text(AppLocalizations.of(context).no),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              _showDialog();
            }
        ),
        title: Text(widget.score.toString() + ' - ' + AppLocalizations.of(context).game),
        backgroundColor: COLOR_MAIN_BLUE,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 10,
            child: PlayerXX1Detail(key: Key('detailPlayerXX1'), currentPlayer: _currentPlayer, players: widget.players, onUpdatePlayer: _handleUpdatePlayer, changePlayer:  _changePlayer),
          ),
          Expanded(
            flex: 2,
            child: MessagePlayer(key: new Key('messagePlayer'), currentPlayer: _currentPlayer, helpMessage: _helpMessage, isEndGame: _isEndGame,),
          ),
          Expanded(
            flex: 10,
            child: Container(
              padding: EdgeInsets.all(8),
              child: ScoringXX1(key: new Key('scoringXX1'), currentPlayer: _currentPlayer, multiply: _multiply, onUpdatePlayer: _handleUpdatePlayer, onUpdateMultiply: _handleUpdateMultiply,),
            ),
          ),
        ],
      ),
    );
  }
}