import 'package:flutter/material.dart';
import 'AddPlayer.dart';
import 'RoomsManager.dart';
import 'CommonColors.dart';


class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Dartagnan'),
            decoration: BoxDecoration(
              color: COLOR_MAIN_BLUE,
            ),
          ),
          ListTile(
            title: Text('Play'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddPlayer(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Rooms'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RoomsManager(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}