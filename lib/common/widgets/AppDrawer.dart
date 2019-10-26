import 'package:flutter/material.dart';
import '../CommonColors.dart';
import 'package:dartagnan/services/SignInService.dart';
import 'package:dartagnan/pages/login/LoginPage.dart';
import 'package:dartagnan/common/CommonColors.dart';
import '../AppLocalizations.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image(image: AssetImage("assets/dart-logo.png"), height: 90.0),
                Column(
                  children: <Widget>[
                    SignInService.imageUrl == null ?
                    CircleAvatar(
                      backgroundColor: COLOR_SECONDARY_YELLOW,
                      child: Text(SignInService.name[0],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Portico',
                          letterSpacing: 0.5,
                        ),
                      ),
                    ) :
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        SignInService.imageUrl,
                      ),
                      radius: 30,
                      backgroundColor: Colors.transparent,
                    ),
                    Text(SignInService.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        SignInService.signOutGoogle();
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();}), ModalRoute.withName('/'));
                      },
                      color: COLOR_SECONDARY_YELLOW,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Icon(Icons.power_settings_new, color: Colors.white,),
                      ),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80)),
                    ),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: COLOR_MAIN_BLUE,
            ),
          ),
          ListTile(
            title: Center(
              child: Text(AppLocalizations.of(context).play, style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/launcher');
            },
          ),
          ListTile(
            title: Center(
              child: Text(AppLocalizations.of(context).rooms, style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/rooms');
            },
          ),
        ],
      ),
    );
  }
}