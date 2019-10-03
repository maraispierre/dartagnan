import 'package:flutter/material.dart';
import 'package:dartagnan/widgets/common/MessagePlayer.dart';
import 'package:dartagnan/widgets/xx1/ScoringXX1.dart';
import 'package:dartagnan/widgets/xx1/PlayerXX1.dart';
import 'package:dartagnan/pages/common/CommonColors.dart';
import 'package:dartagnan/widgets/xx1/PlayerXX1Detail.dart';
import 'package:dartagnan/pages/common/AppLocalizations.dart';

/* Global Widget Page  which contains :
 * - PlayerList for XX1 (PlayerListXX1)
 * - Current round message for XX1
 * - Scoring buttons for XX1 (ScoringXX1)
 * - Strategy to manage XX1 game
 */

class GameXX1 extends StatefulWidget {
  GameXX1({Key key, this.players, this.endByDouble, this.score,}) : super(key: key);

  final List<PlayerXX1> players;
  final bool endByDouble;
  final int score;

  @override
  _GameXX1State createState() => _GameXX1State();
}

/* State form StatefulWidget GameXX1*/
class _GameXX1State extends State<GameXX1> {

  PlayerXX1 _currentPlayer;
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

    for(PlayerXX1 player in widget.players){
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
  void _handleUpdatePlayer(PlayerXX1 player) {
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
    });
  }

  /* method call to verify and process end game if game is over */
  bool _endGame(PlayerXX1 player) {
    if(_currentPlayer.score == 0) {
      _isEndGame = true;
      _helpMessage = '';
      for(PlayerXX1 player in widget.players){
        player.resetPlayer(widget.score);
      }
      return true;
    }
    return false;
  }

  /* method call to verify that current player score is less than that zero */
  bool _badScore(PlayerXX1 player) {
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
      _currentPlayer.totalScore = _currentPlayer.totalScore - _currentPlayer.firstDart - _currentPlayer.secondDart - _currentPlayer.thirdDart;
      _currentPlayer.round--;
      _changePlayer = true;
      return true;
    }
    _changePlayer = false;
    return false;
  }

  /* method call to go to next player when the current player shooted this 3 darts */
  bool _nextPlayer(PlayerXX1 player) {
   if(player.thirdDart != null) {
      player.round++;
      player.totalScore = player.totalScore + player.firstDart + player.secondDart + player.thirdDart;
      player.average = player.totalScore / player.round;
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
  void _initRound(PlayerXX1 player) {
    player.firstDart = null;
    player.secondDart = null;
    player.thirdDart = null;
    _changePlayer = true;
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
      return null;
    }
    else {
      for(int i = 1; i < 4; i++) {
        for(int j = 1; j < 21; j++) {
          if(remaining - i * j == 0) {
            return i.toString() + 'X' + j.toString();
          }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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