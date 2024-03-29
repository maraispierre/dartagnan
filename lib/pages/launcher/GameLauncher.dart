import 'package:flutter/material.dart';
import 'package:dartagnan/common/widgets/AddPlayerListItem.dart';
import 'package:dartagnan/pages/xx1/GameXX1.dart';
import 'package:dartagnan/pages/cricket/GameCricket.dart';
import 'package:dartagnan/common/Player.dart';
import '../../common/AppLocalizations.dart';
import '../../common/CommonColors.dart';
import '../../services/RoomService.dart';
import '../../common/widgets/AppDrawer.dart';
import 'package:dartagnan/common/Room.dart';
import 'dart:math';

enum ChoiceGame { CRICKET, XX1 }
enum ChoiceStartWidth { RANDOM, BEST_START }
/* Widget page to add Player and start game XX1 */
class GameLauncher extends StatefulWidget {

  GameLauncher({this.isOffline = false});
  final bool isOffline;

  @override
  GameLauncherState createState() {
    return GameLauncherState();
  }
}

/* State of GameXX1AddPlayer */
class GameLauncherState extends State<GameLauncher> {

  static const List<String> scores = ['301', '401', '501', '601', '701', '801', '901', '1001'];
  static const List<ChoiceStartWidth> startWidth = [ChoiceStartWidth.RANDOM, ChoiceStartWidth.BEST_START];

  final _formKey = GlobalKey<FormState>();
  List<Player> _players = [];
  int _score = 301;
  ChoiceStartWidth _startWidth = ChoiceStartWidth.BEST_START;
  Room _currentRoom = Room(name: 'Choisir un salon', id: -1, players: []);
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

  void _handleUpdateChangeStartWith(ChoiceStartWidth value) {
    setState(() {
      _startWidth = value;
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
    if(_players.length > 0 || (_currentRoom != null && _currentRoom.id != -1 && _currentRoom.players.length > 0)) {
      if(_startWidth == ChoiceStartWidth.BEST_START) {
        _players.sort((Player a, Player b) {
          if(a.numberWonGame < b.numberWonGame) return 1;
          if(a.numberWonGame > b.numberWonGame) return -1;
          return 0;
        });
      }
      else{
        _players = shuffle(_players);
      }
      switch(_choiceGame){
        case ChoiceGame.XX1 :
          for(Player player in _currentRoom.players) {
            player.score = _score;
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GameXX1(
              players: _players,
              endByDouble: _endByDouble,
              score: _score,
              room: _currentRoom,
            ),
            ),
          );
          break;
        case ChoiceGame.CRICKET :
          for(Player player in _players) {
            player.score = 0;
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GameCricket(
              players: _players,
              score: 0,
              room: _currentRoom,
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

  List shuffle(List items) {
    var random = new Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {

      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    _players.sort((Player a, Player b) {
      if(a.numberWonGame < b.numberWonGame) return 1;
      if(a.numberWonGame > b.numberWonGame) return -1;
      return 0;
    });
    return Scaffold(
      drawer: widget.isOffline ? null : AppDrawer(),

      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: widget.isOffline ? new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            }
        ) : null,
        backgroundColor: COLOR_MAIN_BLUE,
        title: Text(AppLocalizations.of(context).titleAddPlayer),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 8,
            child: ListView(
              shrinkWrap: true,
              controller: _scrollController,
              children: _players.map((Player player) {
                return AddPlayerListItem(player: player, players: _players, removePlayerCallback: _handleRemovePlayer,);
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
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 12
                        ),
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
          Visibility(visible: !widget.isOffline,
            child: FutureBuilder<List<Room>>(
              future: RoomService().fetchRooms(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<DropdownMenuItem> items = [];
                  items.add(DropdownMenuItem(child: Text(AppLocalizations.of(context).chooseRoom), value: Room(name: AppLocalizations.of(context).chooseRoom , id: -1, players: []),));
                  for(var room in snapshot.data) {
                    items.add(DropdownMenuItem(
                        value: room,
                        child: Text(room.id == -1 ? AppLocalizations.of(context).chooseRoom : room.name),
                    ));
                  }
                  return DropdownButton(
                    items: items,
                    hint: Text(_currentRoom == null ? AppLocalizations.of(context).chooseRoom : _currentRoom.name,
                      style: TextStyle(
                        color: _currentRoom.name == AppLocalizations.of(context).chooseRoom  ? Colors.black26 : COLOR_MAIN_BLUE
                      ),
                    ),
                    onChanged: (room) {
                      setState(() {
                        _currentRoom = room;
                        _players = _currentRoom.players;
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
                    fontFamily: 'Portico',
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
                    fontFamily: 'Portico',
                    letterSpacing: 0.5,
                    color: _choiceGame == ChoiceGame.CRICKET ? COLOR_MAIN_BLUE : Colors.black12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 400,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(AppLocalizations.of(context).startWith,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Portico',
                        letterSpacing: 0.5,
                      ),
                    ),
                    DropdownButton<ChoiceStartWidth>(
                      value: _startWidth,
                      onChanged: (ChoiceStartWidth value) => _handleUpdateChangeStartWith(value),
                      items: startWidth
                          .map<DropdownMenuItem<ChoiceStartWidth>>((ChoiceStartWidth value) {
                        return DropdownMenuItem<ChoiceStartWidth>(
                          value: value,
                          child: Text(value == ChoiceStartWidth.BEST_START ? AppLocalizations.of(context).bestStart : AppLocalizations.of(context).random,
                            style: TextStyle(
                              fontSize: 13,
                              color: COLOR_MAIN_BLUE,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Portico',
                              letterSpacing: 0.5,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
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
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Portico',
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
                                    fontSize: 18,
                                    color: COLOR_MAIN_BLUE,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Portico',
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
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Portico',
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
                    fontFamily: 'Portico',
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