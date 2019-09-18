import 'package:flutter/material.dart';
import 'PlayerCricket.dart';
import 'package:flutter_dart_score/pages/common/CommonColors.dart';
import 'package:flutter_dart_score/widgets/cricket/PlayerListCricket.dart';
import 'package:flutter_dart_score/widgets/cricket/TablePlayerListItemCricket.dart';

typedef void UpdateUserCallback(PlayerCricket player);

/* Widget to display the detail of a player during the game */
class PlayerCricketDetail extends StatefulWidget {
  PlayerCricketDetail({Key key, this.currentPlayer, this.players, this.onUpdatePlayer, this.changePlayer}) : super(key: key);

  final PlayerCricket currentPlayer;
  final List<PlayerCricket> players;
  final UpdateUserCallback onUpdatePlayer;
  final bool changePlayer;

  @override
  _PlayerCricketDetailState createState() => _PlayerCricketDetailState();

}

class _PlayerCricketDetailState extends State<PlayerCricketDetail> with TickerProviderStateMixin {

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.changePlayer) {
      _controller = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      )..forward();
    }
    return AnimatedBuilder(
        animation: _controller,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 60,
                width: 60,
                child: CircleAvatar(
                  backgroundColor: COLOR_SECONDARY_YELLOW,
                  child: Text(widget.currentPlayer.name[0],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              Text(widget.currentPlayer.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                ),
              ),
              Text(widget.currentPlayer.score.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(widget.currentPlayer.firstDart != null ? widget.currentPlayer.firstDart.toString() : '-',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      fontSize: 20,
                    ),
                  ),
                  Text(widget.currentPlayer.secondDart != null ? widget.currentPlayer.secondDart.toString() : '-',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      fontSize: 20,
                    ),
                  ),
                  Text(widget.currentPlayer.thirdDart != null ? widget.currentPlayer.thirdDart.toString() : '-',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Roboto',
                      letterSpacing: 0.5,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
              TablePlayerListItemCricket(players: widget.players, tableScore: widget.currentPlayer.tableCricket, isCurrentPlayer: false, smallSize: false,),
              RaisedButton(
                child: Text('SEE ALL', style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Roboto',
                  letterSpacing: 0.5,
                ),
                ),
                color: COLOR_MAIN_BLUE,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:  (context) => AlertDialog(
                      content: PlayerListCricket(key: Key('playersListCricket'), currentPlayer: widget.currentPlayer, players: widget.players, onUpdatePlayer:  widget.onUpdatePlayer, ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      builder: (BuildContext context, Widget child) {
        return Transform.scale(scale: _controller.value,
          child: child,
        );
      },
    );
  }

}