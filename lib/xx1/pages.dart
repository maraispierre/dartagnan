import 'package:flutter/material.dart';
import 'widgets.dart';

/* Global Widget Page  which contains :
 * - PlayerList for XX1 (PlayerListXX1)
 * - Current round message for XX1
 * - Scoring buttons for XX1 (ScoringXX1)
 * - Strategy to manage XX1 game
 */
class GameXX1 extends StatefulWidget {
  GameXX1({Key key, this.players}) : super(key: key);

  final List<Player> players;

  @override
  _GameXX1State createState() => _GameXX1State();
}

/* State form StatefulWidget GameXX1*/
class _GameXX1State extends State<GameXX1> {

  Player _currentPlayer;
  String _message;
  int _counterPlayer;
  int _multiply;

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    _currentPlayer = widget.players[0];
    _message = 'Round ' + (_currentPlayer.round + 1).toString() + ' of ' + _currentPlayer.name;
    _counterPlayer = 0;
    _multiply = 1;
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
  bool _endGame(Player player) {
    if(_currentPlayer.score == 0) {
      _message = _currentPlayer.name + ' a gagné la partie.';
      for(player in widget.players){
        _resetPlayer(player);
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
      _currentPlayer.round--;
      return true;
    }
    return false;
  }

  /* method call to go to next player when the current player shooted this 3 darts */
  bool _nextPlayer(Player player) {
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
    return false;
  }

  /* method call to reset player after each end game */
  void _resetPlayer(Player player) {
    player.score = 301;
    player.firstDart = null;
    player.secondDart = null;
    player.thirdDart = null;
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
    _message = 'Round ' + (_currentPlayer.round + 1).toString() + ' of ' + _currentPlayer.name + ' ' + _generateHelpMessage();
  }

  /* method calls to display a help message to a player when it can end game */
  String _generateHelpMessage() {
    int nbRemainingDart = _getNumberRemainingDart();
    int nbNecessaryDart = _getNumberNecessaryDart();
    if(nbNecessaryDart <= 3 && nbRemainingDart>= nbNecessaryDart) {
      String lastDart = _getLastDart(_currentPlayer.score);
      if(nbNecessaryDart == 3 && lastDart != null) {
        return '[ 3X20 3X20 ' + lastDart + ' ]';
      }
      else if(nbNecessaryDart == 3) {
        int remaining = _currentPlayer.score - 60;
        for(int i = 1; i < 4; i++) {
          for(int j= 1; j < 21; j++) {
            String trueLastDart = _getLastDart(remaining - i * j);
            if( trueLastDart != null) {
              return '[ 3X20 '+ i.toString() + 'X' + j.toString() + ' '+ trueLastDart + ' ]';
            }
          }
        }
      }
      else if(nbNecessaryDart == 2 && lastDart != null) {
        return '[ 3X20 ' + lastDart + ' ]';
      }
      else if(nbNecessaryDart == 2) {
        int remaining = _currentPlayer.score;
        for(int i = 1; i < 4; i++) {
          for(int j= 1; j < 21; j++) {
            String trueLastDart = _getLastDart(remaining - i * j);
            if( trueLastDart != null) {
              return '[ '+ i.toString() + 'X' + j.toString() + ' '+ trueLastDart + ' ]';
            }
          }
        }
      }
      else if(nbNecessaryDart == 1 && lastDart != null){
        return '[ ' + lastDart + ' ]';
      }
    }
    return '';
  }

  /* method call to return the last dart to finish or null if it doesn't possible */
  String _getLastDart(int score){
    int remaining = score;
    for(int i = 1; i < 4; i++) {
      for(int j = 1; j < 21; j++) {
        if(remaining - i * j == 0) {
          return i.toString() + 'X' + j.toString();
        }
      }
    }
    return null;
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
        title: Text('XX1 - Game'),
        backgroundColor: Colors.black26,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 5,
            child: PlayerListXX1(key: widget.key, players: widget.players, currentPlayer: _currentPlayer, onUpdatePlayer: _handleUpdatePlayer,),
          ),
          Expanded(
            flex: 1,
            child: Text('$_message',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Roboto',
                letterSpacing: 0.5,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.all(8),
              child: ScoringXX1(currentPlayer: _currentPlayer, multiply: _multiply, onUpdatePlayer: _handleUpdatePlayer, onUpdateMultiply: _handleUpdateMultiply,),
            ),
          ),
        ],
      ),
    );
  }
}

/* Widget page to add Player and start game XX1 */
class GameXX1AddPlayer extends StatefulWidget {

  @override
  GameXX1AddPlayerState createState() {
    return GameXX1AddPlayerState();
  }
}

/* State of GameXX1AddPlayer */
class GameXX1AddPlayerState extends State<GameXX1AddPlayer> {

  static const List<String> scores = ['301', '401', '501', '601', '701', '801', '901', '1001'];

  final _formKey = GlobalKey<FormState>();
  List<Player> _players = [];
  int _score = 301;

  /* method call to add player to the game after click on add button */
  void _handleUpdateAddPlayer(String namePlayer) {
    setState(() {
      _players.add(new Player(name: namePlayer, score: _score,));
    });
  }

  /* method call to change score after select a new starting score */
  void _handleUpdateChangeScore(String score) {
    setState(() {
      _score = int.parse(score);
      for(Player player in _players) {
        player.score = _score;
      }
    });
  }

  /* method call to remove player to the game after click on remove button */
  void _handleRemovePlayer(String namePlayer) {
    setState(() {
      for(int i = 0; i< _players.length; i++) {
        if(_players[i].name == namePlayer) {
          _players.remove(_players[i]);
          break;
        }
      }
    });
  }

  /* method call to start the game */
  void _handleStartGame() {
    if(_players.length > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GameXX1(
          players: _players,
        ),
        ),
      );
    }
  }

  /* method calls to validate adding player */
  void _handleValidateAddPlayerForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _formKey.currentState.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text('XX1 - Add Players'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            scrollDirection: Axis.vertical,
            children: _players.map((Player player) {
              return AddPlayerListItem(player: player, removePlayerCallback: _handleRemovePlayer,);
            }).toList(),
          ),
          Form(
            key: _formKey,
            child: Row (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person, color: Colors.black,),
                      hintText: 'Name',
                      labelText: 'Add a player',
                      labelStyle: TextStyle(color: Colors.black,),
                      focusColor: Colors.black,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please add a player';
                      }
                      return null;
                    },
                    onSaved: (namePlayer) => _handleUpdateAddPlayer(namePlayer),
                  ),
                ),
                SizedBox(
                  width: 35.0,
                  height: 35.0,
                  child: FloatingActionButton(
                    backgroundColor: Colors.black,
                    heroTag: "btnAdd",
                    child: Icon(Icons.add),
                    onPressed: () {
                      _handleValidateAddPlayerForm();
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Score',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                ),
              ),
              DropdownButton<String>(
                value: _score.toString(),
                onChanged: (String score) => _handleUpdateChangeScore(score),
                items: scores
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        letterSpacing: 0.5,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          Center(
            child: RaisedButton(
              color: Colors.black,
              child: Text('PLAY',
                style: TextStyle(
                color: Colors.white,
                ),
              ),
              onPressed: () {
                _handleStartGame();
              },
            ),
          ),
        ],
      ),

    );
  }
}