import 'package:flutter/material.dart';
import 'package:flutter_dart_score/widgets/widgets.dart';
import 'package:flutter_dart_score/widgets/widgetsCricket.dart';

/* Global Widget Page  which contains :
 * - PlayerList for Cricket (PlayerListCricket)
 * - Current round message for Cricket
 * - Scoring buttons for Cricket (ScoringCricket)
 * - Strategy to manage Cricket game
 */
class GameCricket extends StatefulWidget {
  GameCricket({Key key, this.players, this.endByDouble}) : super(key: key);

  final List<Player> players;
  final bool endByDouble;
  @override
  _GameCricketState createState() => _GameCricketState();
}

/* State form StatefulWidget GameXX1*/
class _GameCricketState extends State<GameCricket> {

  Player _currentPlayer;
  String _message;
  String _helpMessage;
  int _counterPlayer;
  int _multiply;

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    _currentPlayer = widget.players[0];
    _message = 'Round ' + (_currentPlayer.round + 1).toString() + ' of ' + _currentPlayer.name;
    _helpMessage = '';
    _counterPlayer = 0;
    _multiply = 1;
    for(Player player in widget.players) {
      player.score = 0;
    }
  }

  /* Methods call for update player information after an action. It is the global strategy of XX1 game */
  void _handleUpdateMultiply(int multiply) {
    setState(() {
      _multiply = multiply;
    });
  }

  /* Methods call for update player information after an action. It is the global strategy of XX1 game */
  void _handleUpdatePlayer(Player player) {
    setState(() {
      _currentPlayer = player;
      // Verify if the current player finished the game
      if(_endGame(_currentPlayer)) {
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
  bool _endGame(Player player) {
    bool endGame = true;
    player.tableCricket.forEach((key, value) {
      if(value<3) {
        endGame = false;
      }
    });
    if(!endGame) {
      return false;
    }
    else {
      for(Player player in widget.players) {
        if(player.score > _currentPlayer.score) {
          endGame = false;
        }
      }
      if(endGame) {
        _message = _currentPlayer.name + ' a gagné la partie.';
        _helpMessage = '';
        for(player in widget.players){
          _resetPlayer(player);
        }
      }
      return endGame;
    }
  }


  /* method call to back to the previous player */
  bool _backToPreviousPlayer() {
    if(_currentPlayer.backward && _currentPlayer.round == 0 && (_currentPlayer.name == widget.players[0].name) && _currentPlayer.firstDart == null) {
      _currentPlayer.backward = false;
      return true;
    }
    else if(_currentPlayer.backward && _currentPlayer.firstDart == null){
      _currentPlayer.backward = false;
      if(_counterPlayer == 0) {
        _counterPlayer = widget.players.length - 1;
        _currentPlayer = widget.players[_counterPlayer];
      }
      else {
        _counterPlayer--;
        _currentPlayer = widget.players[_counterPlayer];
      }
      _currentPlayer.round--;
      return true;
    }
    else if(_currentPlayer.backward) {
      StateHistorical historical = _currentPlayer.historical.removeLast();
      _currentPlayer.score = historical.score;
      _currentPlayer.tableCricket = historical.tableCricket;
      _currentPlayer.firstDart = historical.firstDart;
      _currentPlayer.secondDart = historical.secondDart;
      _currentPlayer.thirdDart = historical.thirdDart;
      return true;
    }
    return false;
  }

  /* method call to go to next player when the current player shooted this 3 darts */
  bool _nextPlayer(Player player) {
    if(player.thirdDart != null) {
      player.round++;
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
    return false;
  }

  /* method call to reset player after each end game */
  void _resetPlayer(Player player) {
    player.score = 0;
    player.firstDart = null;
    player.secondDart = null;
    player.thirdDart = null;
    player.tableCricket.forEach( (key, value) {
      player.tableCricket[key] = 0;
    });
    player.round = 0;
    player.totalScore = 0;
    player.average = 0;
  }

  /* method call to init round before each next round */
  void _initRound(Player player) {
    player.firstDart = null;
    player.secondDart = null;
    player.thirdDart = null;
  }

  /* method calls to display message after each dart of a player */
  void _generateMessage() {
    _message = 'Round ' + (_currentPlayer.round + 1).toString() + ' of ' + _currentPlayer.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cricket - Game'),
        backgroundColor: Colors.black26,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 10,
            child: PlayerListCricket(key: widget.key, players: widget.players, currentPlayer: _currentPlayer, onUpdatePlayer: _handleUpdatePlayer,),
          ),
          Expanded(
            flex: 2,
            child: MessagePlayer(message: _message, helpMessage: _helpMessage,),
          ),
          Expanded(
            flex: 10,
            child: Container(
              padding: EdgeInsets.all(8),
              child: ScoringCricket(currentPlayer: _currentPlayer, players: widget.players, multiply: _multiply, onUpdatePlayer: _handleUpdatePlayer, onUpdateMultiply: _handleUpdateMultiply,),
            ),
          ),
        ],
      ),
    );
  }
}