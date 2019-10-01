import 'package:flutter/material.dart';
import 'CommonColors.dart';
import 'AppDrawer.dart';
import 'Room.dart';
import 'package:flutter_dart_score/widgets/common/AddRoomListItem.dart';
import 'RoomService.dart';


/* Widget page to manage rooms*/
class RoomsManager extends StatefulWidget {

  @override
  RoomsManagerState createState() {
    return RoomsManagerState();
  }
}

/* State of GameXX1AddPlayer */
class RoomsManagerState extends State<RoomsManager> {

  Future<List<Room>> rooms;

  @override
  void initState() {
    super.initState();
    rooms = new RoomService().fetchRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: COLOR_MAIN_BLUE,
        title: Text('Gestion des Rooms'),
      ),
      body: Container(
        child: FutureBuilder<List<Room>>(
          future: rooms,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                  shrinkWrap: true,
                  children: snapshot.data.map((Room room) {
                    return AddRoomListItem(room: room,);
                  }).toList(),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}