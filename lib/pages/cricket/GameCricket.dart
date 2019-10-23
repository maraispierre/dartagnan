import 'package:flutter/material.dart';
import 'package:dartagnan/common/widgets/MessagePlayer.dart';
import 'package:dartagnan/pages/cricket/widgets/PlayerCricketDetail.dart';
import 'package:dartagnan/common/Player.dart';
import 'package:dartagnan/pages/cricket/widgets/StateHistorical.dart';
import 'package:dartagnan/pages/cricket/widgets/ScoringCricket.dart';
import 'package:dartagnan/common/CommonColors.dart';
import 'package:dartagnan/common/AppLocalizations.dart';
import 'package:dartagnan/services/RoomService.dart';
import 'package:dartagnan/common/Room.dart';

/* Global Widget Page  which contains :
 * - PlayerList for Cricket (PlayerListCricket)
 * - Current round message for Cricket
 * - Scoring buttons for Cricket (ScoringCricket)
 * - Strategy to manage Cricket game
 */
class GameCricket extends StatefulWidget {
  GameCricket({Key key, this.players, this.score, this.room}) : super(key: key);

  final List<Player> players;
  final int score;
  final Room room;

  @override
  _GameCricketState createState() => _GameCricketState();
}

/* State form StatefulWidget GameXX1 */
class _GameCricketState extends State<GameCricket> {

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
    _isEndGame = false;
    _helpMessage = '';
    _counterPlayer = 0;
    _multiply = 1;
    _changePlayer = true;
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
      _changePlayer = false;
      _isEndGame = false;
      _currentPlayer = player;
      // Verify if the current player finished the game
      if(_endGame(_currentPlayer)) {
        return;
      }
      // Verify if the user call to back to the previous player
      else if(_backToPreviousPlayer()){
        return;
      }
      // Go to next player when the current player shooted this 3 darts
      else if(_nextPlayer(_currentPlayer)) {
        return;
      }
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
        _isEndGame = true;
        _helpMessage = '';
        player.numberWonGame++;

        for(Player player in widget.players){
         player.updateStatsCricket();
         player.resetPlayer(widget.score);
        }
        if(widget.room.id != -1) {
          RoomService().updateRoom(widget.room);
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
      _changePlayer = true;
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
    _changePlayer = false;
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

  /* method call to init round before each next round */
  void _initRound(Player player) {
    player.firstDart = null;
    player.secondDart = null;
    player.thirdDart = null;
    _changePlayer = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cricket - ' + AppLocalizations.of(context).game),
        backgroundColor: COLOR_MAIN_BLUE,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 10,
            child: PlayerCricketDetail(key: Key('detailPlayer'), players: widget.players, currentPlayer: _currentPlayer, onUpdatePlayer: _handleUpdatePlayer, changePlayer: _changePlayer,),
          ),
          Expanded(
            flex: 2,
            child: MessagePlayer(key: new Key('messagePlayer'), currentPlayer: _currentPlayer, helpMessage: _helpMessage, isEndGame: _isEndGame,),
          ),
          Expanded(
            flex: 10,
            child: Container(
              padding: EdgeInsets.all(8),
              child: ScoringCricket(key: new Key('scoringCricket'), currentPlayer: _currentPlayer, players: widget.players, multiply: _multiply, onUpdatePlayer: _handleUpdatePlayer, onUpdateMultiply: _handleUpdateMultiply,),
            ),
          ),
        ],
      ),
    );
  }
}