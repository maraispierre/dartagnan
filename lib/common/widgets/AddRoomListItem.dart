import 'package:flutter/material.dart';
import 'package:dartagnan/common/Room.dart';
import 'package:dartagnan/common/CommonColors.dart';
import 'package:dartagnan/pages/rooms/RoomDetailPage.dart';

typedef void RemoveRoomCallback(Room room);

/* Widget to display detail of an adding player */
class AddRoomListItem extends StatelessWidget {

  AddRoomListItem({Room room, RemoveRoomCallback removeRoomCallback})
      : room = room,
        onRemoveRoomCallback = removeRoomCallback,
        super(key: ObjectKey(room));

  final Room room;
  final RemoveRoomCallback onRemoveRoomCallback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          backgroundColor: COLOR_MAIN_BLUE,
          child: Text(room.name[0],
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 100,
              child: Text(room.name,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 35.0,
                  height: 35.0,
                  child: FloatingActionButton(
                    heroTag: "btnEdit" + room.name,
                    backgroundColor: Colors.green,
                    child: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RoomDetailPage(room: room,)
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 35.0,
                  height: 35.0,
                  child: FloatingActionButton(
                    heroTag: "btnRemove" + room.name,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.remove),
                    onPressed: () {
                      onRemoveRoomCallback(room);
                    },
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
}