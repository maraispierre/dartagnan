import 'package:flutter/material.dart';
import 'CommonColors.dart';
import 'Room.dart';
import 'package:flutter_dart_score/widgets/common/Player.dart';
import 'package:flutter_dart_score/widgets/common/AddPlayerListItem.dart';
import 'RoomService.dart';
import 'AppLocalizations.dart';


/* Widget page to display detail page */
class RoomDetailPage extends StatefulWidget {

  RoomDetailPage({this.room});

  final Room room;

  @override
  RoomDetailPageState createState() {
    return RoomDetailPageState();
  }
}

/* State of GameXX1AddPlayer */
class RoomDetailPageState extends State<RoomDetailPage> {

  final _formKey = GlobalKey<FormState>();
  Room room;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    room = widget.room;
    super.initState();
  }

  /* method calls to validate adding Room */
  void _handleValidateAddRoomForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _formKey.currentState.reset();
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  /* method call to add room to the game after click on add button */
  void _handleUpdateAddPlayer(String namePlayer) async{
    Room newRoom = await new RoomService().addUser(room, namePlayer);
    setState(() {
      room = newRoom;
    });
  }

  /* method call to remove rooms to the game after click on remove button */
  void _handleRemovePlayer(Player player) async{
    Room newRoom = await new RoomService().removeUser(room, player.id);
    setState(() {
      room = newRoom;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: COLOR_MAIN_BLUE,
        title: Text(room.name),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: ListView(
                shrinkWrap: false,
                controller: _scrollController,
                children: room.players.map((Player player) {
                  return AddPlayerListItem(player: player, removePlayerCallback: _handleRemovePlayer);
                }).toList(),
              ),
            ),
            Expanded(
              flex: 6,
              child: Form(
                key: _formKey,
                child: Row (
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        cursorColor: COLOR_MAIN_BLUE,
                        decoration: InputDecoration(
                          icon: Icon(Icons.add, color: COLOR_MAIN_BLUE,),
                          hintText: AppLocalizations.of(context).addPlayerFieldName,
                          labelText: AppLocalizations.of(context).addPlayerField,
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
                          _handleValidateAddRoomForm();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}