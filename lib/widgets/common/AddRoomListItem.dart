import 'package:flutter/material.dart';
import 'package:flutter_dart_score/pages/common/Room.dart';
import 'package:flutter_dart_score/pages/common/CommonColors.dart';

typedef void UpdateMultiplyCallback(int multiply);
typedef void RemovePlayerCallback(String namePlayer);

/* Widget to display detail of an adding player */
class AddRoomListItem extends StatelessWidget {

  AddRoomListItem({Room room})
      : room = room,
        super(key: ObjectKey(room));

  final Room room;

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
          ],
        )
    );
  }
}