import 'package:flutter/material.dart';
import 'package:flutter_dart_score/widgets/widgets.dart';
import 'pageXX1.dart';
import 'package:flutter_dart_score/pages/pageCricket.dart';

enum ChoiceGame { CRICKET, XX1 }

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
      for(Player player in _players) {
        _resetPlayer(player);
      }
      switch(_choiceGame){
        case ChoiceGame.XX1 :
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GameXX1(
              players: _players,
              endByDouble: _endByDouble,
            ),
            ),
          );
          break;
        case ChoiceGame.CRICKET :
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GameCricket(
              players: _players,
              endByDouble: _endByDouble,
            ),
            ),
          );
          break;
      }
    }
  }

  /* method call to reset player after each end game */
  void _resetPlayer(Player player) {
    player.score = _score;
    player.firstDart = null;
    player.secondDart = null;
    player.thirdDart = null;
    player.tableCricket = new Map();
    player.tableCricket[15] = 0;
    player.tableCricket[16] = 0;
    player.tableCricket[17] = 0;
    player.tableCricket[18] = 0;
    player.tableCricket[19] = 0;
    player.tableCricket[20] = 0;
    player.tableCricket[25] = 0;
    player.round = 0;
    player.totalScore = 0;
    player.average = 0;
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
        title: Text('XX1 - Add Players'),
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
                Text('XX1'),
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
                Text('Cricket'),
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