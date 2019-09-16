import 'package:flutter/material.dart';
import 'package:flutter_dart_score/pages/common/CommonColors.dart';

/* widget which contains message for player */
class MessagePlayer extends StatelessWidget {

  MessagePlayer({Key key, this.message, this.helpMessage}) : super(key: key);

  final String message;
  final String helpMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: COLOR_SECONDARY_YELLOW,
      ),
      child: Center(
          child : Column(
            children: <Widget>[
              Text(message,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                ),
              ),
              Text(helpMessage,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                ),
              ),
            ],
          )
      ),
    );
  }
}