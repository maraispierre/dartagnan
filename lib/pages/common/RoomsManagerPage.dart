import 'package:flutter/material.dart';
import 'CommonColors.dart';
import 'AppDrawer.dart';
import 'Room.dart';
import 'package:dartagnan/widgets/common/AddRoomListItem.dart';
import 'RoomService.dart';
import 'AppLocalizations.dart';


/* Widget page to manage rooms*/
class RoomsManagerPage extends StatefulWidget {

  @override
  RoomsManagerPageState createState() {
    return RoomsManagerPageState();
  }
}

/* State of GameXX1AddPlayer */
class RoomsManagerPageState extends State<RoomsManagerPage> {

  List<Room> rooms = [];
  final _formKey = GlobalKey<FormState>();
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
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
  void _handleUpdateAddRoom(String nameRoom) async{
    Room room = await new RoomService().createRoom(nameRoom);
    setState(() {
      rooms.add(room);
    });
  }

  /* method call to remove rooms to the game after click on remove button */
  void _handleRemoveRoom(Room room) async{
    await new RoomService().deleteRoom(room);

    setState(() {
      rooms.remove(room);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: COLOR_MAIN_BLUE,
        title: Text('Gestion des Rooms'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            FutureBuilder<List<Room>>(
              future: new RoomService().fetchRooms(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    flex: 4,
                    child: ListView(
                      shrinkWrap: false,
                      controller: _scrollController,
                      children: snapshot.data.map((Room room) {
                        return AddRoomListItem(room: room, removeRoomCallback: _handleRemoveRoom,);
                      }).toList(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
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
                          labelText: 'Add a room',
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
                        onSaved: (nameRoom) => _handleUpdateAddRoom(nameRoom),
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