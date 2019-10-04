import 'package:flutter/material.dart';
import '../../pages/launcher/GameLauncher.dart';
import '../../pages/rooms/RoomsManagerPage.dart';
import '../CommonColors.dart';
import 'package:dartagnan/services/SignInService.dart';
import 'package:dartagnan/pages/login/LoginPage.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    imageUrl,
                  ),
                  radius: 40,
                  backgroundColor: Colors.transparent,
                ),
                RaisedButton(
                  onPressed: () {
                    signOutGoogle();
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
                  },
                  color: COLOR_SECONDARY_YELLOW,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Sign Out',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: COLOR_MAIN_BLUE,
            ),
          ),
          ListTile(
            title: Text('Play'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GameLauncher(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Rooms'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RoomsManagerPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}