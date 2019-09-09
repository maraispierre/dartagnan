import 'package:flutter/material.dart';
import 'package:flutter_dart_score/widgets/common/AddPlayerListItem.dart';
import 'package:flutter_dart_score/pages/xx1/GameXX1.dart';
import 'package:flutter_dart_score/pages/cricket/GameCricket.dart';
import 'package:flutter_dart_score/widgets/common/Player.dart';
import 'package:flutter_dart_score/widgets/xx1/PlayerXX1.dart';
import 'package:flutter_dart_score/widgets/cricket/PlayerCricket.dart';

enum ChoiceGame { CRICKET, XX1 }

/* Widget page to add Player and start game XX1 */
class AddPlayer extends StatefulWidget {

  @override
  AddPlayerState createState() {
    return AddPlayerState();
  }
}

/* State of GameXX1AddPlayer */
class AddPlayerState extends State<AddPlayer> {

  static const List<String> scores = ['301', '401', '501', '601', '701', '801', '901', '1001'];

  final _formKey = GlobalKey<FormState>();
  List<Player> _players = [];
  List<PlayerCricket> _playersCricket = [];
  List<PlayerXX1> _playersXX1 = [];
  int _score = 301;
  ScrollController _scrollController = new ScrollController();
  bool _endByDouble = false;
  ChoiceGame _choiceGame = ChoiceGame.XX1;

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
      switch(_choiceGame){
        case ChoiceGame.XX1 :
          _playersXX1 = [];
          for(Player player in _players) {
            player.resetPlayer(_score);
            var playerX11 = new PlayerXX1(name: player.name, score: _score);
            _playersXX1.add(playerX11);
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GameXX1(
              players: _playersXX1,
              endByDouble: _endByDouble,
              score: _score,
            ),
            ),
          );
          break;
        case ChoiceGame.CRICKET :
          _playersCricket = [];
          for(Player player in _players) {
            player.resetPlayer(_score);
            var playerCricket = new PlayerCricket(name: player.name, score: _score);
            _playersCricket.add(playerCricket);
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GameCricket(
              players: _playersCricket,
              endByDouble: _endByDouble,
              score: _score,
            ),
            ),
          );
          break;
      }
    }
  }

  /* method calls to validate adding player */
  void _handleValidateAddPlayerForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _formKey.currentState.reset();
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent + 15);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text('Add Players'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 6,
            child: ListView(
              shrinkWrap: true,
              controller: _scrollController,
              children: _players.map((Player player) {
                return AddPlayerListItem(player: player, removePlayerCallback: _handleRemovePlayer,);
              }).toList(),
            ),
          ),
          Expanded(
            flex: 2,
            child: Form(
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
          ),
           Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('XX1',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.5,
                    color: _choiceGame == ChoiceGame.XX1 ? Colors.black : Colors.black12,
                  )
                ),
                Radio(
                  groupValue: _choiceGame,
                  value: ChoiceGame.XX1,
                  onChanged: (ChoiceGame value) {
                    setState(() { _choiceGame = value; });
                  },
                  activeColor: Colors.black,
                ),
                Radio(
                  groupValue: _choiceGame,
                  value: ChoiceGame.CRICKET,
                  onChanged: (ChoiceGame value) {
                    setState(() { _choiceGame = value; });
                  },
                  activeColor: Colors.black,
                ),
                Text('Cricket',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.5,
                    color: _choiceGame == ChoiceGame.CRICKET ? Colors.black : Colors.black12,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Visibility(
              visible: _choiceGame == ChoiceGame.XX1,
                child: Container(
                  width: 300,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('Score',
                            style: TextStyle(
                              fontSize: 18,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('End by X2',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto',
                              letterSpacing: 0.5,
                            ),
                          ),
                          Switch(
                            value: _endByDouble,
                            activeColor: Colors.black,
                            onChanged: (value) {
                              _endByDouble = value;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: RaisedButton(
                color: Colors.black,
                child: Text('PLAY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.5,
                  ),
                ),
                onPressed: () {
                  _handleStartGame();
                },
              ),
            ),
          ),

        ],
      ),

    );
  }
}