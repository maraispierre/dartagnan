import 'package:flutter/material.dart';
import '../../services/SignInService.dart';
import '../launcher/GameLauncher.dart';
import 'package:dartagnan/common/CustomIcons.dart';
import 'package:dartagnan/common/CommonColors.dart';
import 'package:dartagnan/common/AppLocalizations.dart';
import 'package:dartagnan/services/SignInService.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("assets/dart-logo.png"), height: 150.0),
              SizedBox(height: 50),
              _signInButton(),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(AppLocalizations.of(context).det_or, style: TextStyle(
                    fontSize: 15,
                    color: COLOR_MAIN_BLUE,
                    fontFamily: 'Portico',
                  ),
                ),
              ),
              _signOffLine(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        SignInService.signInWithGoogle().whenComplete(() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return GameLauncher();
              },
            ),
          );
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                AppLocalizations.of(context).login,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _signOffLine() {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        color: COLOR_SECONDARY_YELLOW,
      ),
      child: OutlineButton(
        borderSide: BorderSide(color: COLOR_SECONDARY_YELLOW, style: BorderStyle.none),
        splashColor: Colors.grey,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return GameLauncher(isOffline: true);
              },
            ),
          );
        },
        child:Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                  CustomIcons.total,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  AppLocalizations.of(context).offline,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}