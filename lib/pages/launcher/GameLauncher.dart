import 'package:flutter/material.dart';
import 'package:dartagnan/common/widgets/AddPlayerListItem.dart';
import 'package:dartagnan/pages/xx1/GameXX1.dart';
import 'package:dartagnan/pages/cricket/GameCricket.dart';
import 'package:dartagnan/common/Player.dart';
import 'package:dartagnan/pages/xx1/widgets/PlayerXX1.dart';
import 'package:dartagnan/pages/cricket/widgets/PlayerCricket.dart';
import '../../common/AppLocalizations.dart';
import '../../common/CommonColors.dart';
import '../../services/RoomService.dart';
import 'package:dartagnan/common/Room.dart';
import '../../common/widgets/AppDrawer.dart';

enum ChoiceGame { CRICKET, XX1 }

/* Widget page to add Player and start game XX1 */
class GameLauncher extends StatefulWidget {

  @override
  GameLauncherState createState() {
    return GameLauncherState();
  }
}

/* State of GameXX1AddPlayer */
class GameLauncherState extends State<GameLauncher> {

  static const List<String> scores = ['301', '401', '501', '601', '701', '801', '901', '1001'];

  final _formKey = GlobalKey<FormState>();
  List<Player> _players = [];
  List<PlayerCricket> _playersCricket = [];
  List<PlayerXX1> _playersXX1 = [];
  int _score = 301;
  Room _currentRoom = null;
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
  void _handleRemovePlayer(Player player) {
    setState(() {
      for(int i = 0; i< _players.length; i++) {
        if(_players[i].name == player.name) {
          _players.remove(_players[i]);
          break;
        }
      }
    });
  }

  /* method call to start the game */
  void _handleStartGame() {
    if(_players.length > 0 || (_currentRoom != null && _currentRoom.id != -1)) {
      switch(_choiceGame){
        case ChoiceGame.XX1 :
          _playersXX1 = [];
          if(_currentRoom == null || _currentRoom.id == -1) {
            for(Player player in _players) {
              var playerX11 = new PlayerXX1(name: player.name, score: _score);
              _playersXX1.add(playerX11);
            }
          }
          else {
            for(Player player in _currentRoom.players) {
              var playerX11 = new PlayerXX1(name: player.name, score: _score);
              _playersXX1.add(playerX11);
            }
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
          if(_currentRoom == null || _currentRoom.id == -1) {
            for(Player player in _players) {
              var playerCricket = new PlayerCricket(name: player.name, score: 0);
              _playersCricket.add(playerCricket);
            }
          }
          else {
            for(Player player in _currentRoom.players) {
              var playerCricket = new PlayerCricket(name: player.name, score: 0);
              _playersCricket.add(playerCricket);
            }
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GameCricket(
              players: _playersCricket,
              score: 0,
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
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent + 50);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: COLOR_MAIN_BLUE,
        title: Text(AppLocalizations.of(context).titleAddPlayer),
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
            flex: 3,
            child: Form(
              key: _formKey,
              child: Row (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      maxLength: 30,
                      cursorColor: COLOR_MAIN_BLUE,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person, color: COLOR_MAIN_BLUE,),
                        hintText: AppLocalizations.of(context).addPlayerFieldName,
                        labelText: AppLocalizations.of(context).addPlayerField ,
                        labelStyle: TextStyle(color: Colors.black,),
                        focusColor: COLOR_MAIN_BLUE,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: COLOR_MAIN_BLUE,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppLocalizations.of(context).addPlayerFieldHelp;
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
                      backgroundColor: COLOR_MAIN_BLUE,
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
          Text('Or'),
          FutureBuilder<List<Room>>(
            future: RoomService().fetchRooms(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<DropdownMenuItem> items = [];
                items.add(DropdownMenuItem(child: Text('Choose a room'), value: Room(name: 'Choose a room', id: -1),));
                for(var room in snapshot.data) {
                  items.add(DropdownMenuItem(
                      value: room,
                      child: Text(room.name)
                  ));
                }
                return DropdownButton(
                  items: items,
                  hint: Text(_currentRoom == null ? 'Choose a room': _currentRoom.name),
                  onChanged: (room) {
                    setState(() {
                      _currentRoom = room;
                    });
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('XX1',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.5,
                    color: _choiceGame == ChoiceGame.XX1 ? COLOR_MAIN_BLUE : Colors.black12,
                  )
                ),
                Radio(
                  groupValue: _choiceGame,
                  value: ChoiceGame.XX1,
                  onChanged: (ChoiceGame value) {
                    setState(() { _choiceGame = value; });
                  },
                  activeColor: COLOR_MAIN_BLUE,
                ),
                Radio(
                  groupValue: _choiceGame,
                  value: ChoiceGame.CRICKET,
                  onChanged: (ChoiceGame value) {
                    setState(() { _choiceGame = value; });
                  },
                  activeColor: COLOR_MAIN_BLUE,
                ),
                Text('Cricket',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.5,
                    color: _choiceGame == ChoiceGame.CRICKET ? COLOR_MAIN_BLUE : Colors.black12,
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
                          Text(AppLocalizations.of(context).endByDouble,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto',
                              letterSpacing: 0.5,
                            ),
                          ),
                          Checkbox(
                            value: _endByDouble,
                            activeColor: COLOR_MAIN_BLUE,
                            onChanged: (value) {
                              setState(() {
                                _endByDouble = value;
                              });
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
                color: COLOR_MAIN_BLUE,
                child: Text(AppLocalizations.of(context).play,
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