import 'package:flutter/material.dart';
import 'package:flutter_dart_score/pages/common/CommonColors.dart';
import 'package:flutter_dart_score/widgets/common/Player.dart';
import 'package:flutter_dart_score/pages/common/AppLocalizations.dart';

/* widget which contains message for player */
class MessagePlayer extends StatelessWidget {

  MessagePlayer({Key key, this.currentPlayer, this.helpMessage, this.isEndGame}) : super(key: key);

  final Player currentPlayer;
  final String helpMessage;
  final bool isEndGame;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: COLOR_SECONDARY_YELLOW,
      ),
      child: Center(
          child : Column(
            children: <Widget>[
              Text(isEndGame ? currentPlayer.name + AppLocalizations.of(context).wonTheGame : AppLocalizations.of(context).round + (currentPlayer.round + 1).toString() + AppLocalizations.of(context).det_of + currentPlayer.name,
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