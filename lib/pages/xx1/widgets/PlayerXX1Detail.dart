import 'package:flutter/material.dart';
import 'package:dartagnan/common/Player.dart';
import 'package:dartagnan/common/CommonColors.dart';
import 'package:dartagnan/pages/xx1/widgets/PlayerListXX1.dart';
import 'package:dartagnan/common/AppLocalizations.dart';
import 'package:dartagnan/common/CustomIcons.dart';

typedef void UpdateUserCallback(Player player);

/* Widget to display the detail of a player during the game */
class PlayerXX1Detail extends StatefulWidget {
  PlayerXX1Detail({Key key, this.currentPlayer, this.players, this.onUpdatePlayer, this.changePlayer}) : super(key: key);

  final Player currentPlayer;
  final List<Player> players;
  final UpdateUserCallback onUpdatePlayer;
  final bool changePlayer;

  @override
  _PlayerListDetailState createState() => _PlayerListDetailState();

}

class _PlayerListDetailState extends State<PlayerXX1Detail> with TickerProviderStateMixin {

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

  /* This methods returns the current dart of player */
  int currentDart() {
    if(widget.currentPlayer.firstDart != null && widget.currentPlayer.secondDart == null ) {
      return 1;
    }
    else if(widget.currentPlayer.secondDart != null && widget.currentPlayer.thirdDart == null ) {
      return 2;
    }
    else if(widget.currentPlayer.thirdDart != null) {
      return 3;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    if(widget.changePlayer) {
      if(_controller != null) {
        _controller.reset();
      }
      _controller = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      )..forward();
    }

    return AnimatedBuilder(
        animation: _controller,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      fontFamily: 'Portico',
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
                  fontFamily: 'Portico',
                  letterSpacing: 0.5,
                ),
              ),
              Text(widget.currentPlayer.score.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Portico',
                  letterSpacing: 0.5,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        CustomIcons.first_dart,
                        color: currentDart() == 1 ? COLOR_MAIN_BLUE : Colors.grey,
                      ),
                      AnimatedDefaultTextStyle(
                        style: currentDart() == 1 ?
                        TextStyle(
                          color: COLOR_MAIN_BLUE,
                          fontFamily: 'Portico',
                          letterSpacing: 0.5,
                          fontSize: 25,
                        ):
                        TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Portico',
                          letterSpacing: 0.5,
                          fontSize: 20,
                        ),
                        duration: Duration(milliseconds: 200),
                        child: Text(widget.currentPlayer.firstDart != null ? widget.currentPlayer.firstDart.toString() : '-',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        CustomIcons.second_dart,
                        color: currentDart() == 2 ? COLOR_MAIN_BLUE : Colors.grey,
                      ),
                      AnimatedDefaultTextStyle(
                        style: currentDart() == 2 ?
                        TextStyle(
                          color: COLOR_MAIN_BLUE,
                          fontFamily: 'Portico',
                          letterSpacing: 0.5,
                          fontSize: 25,
                        ):
                        TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Portico',
                          letterSpacing: 0.5,
                          fontSize: 20,
                        ),
                        duration: Duration(milliseconds: 200),
                        child: Text(widget.currentPlayer.secondDart != null ? widget.currentPlayer.secondDart.toString() : '-',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        CustomIcons.third_dart,
                        color: currentDart() == 3 ? COLOR_MAIN_BLUE : Colors.grey,
                      ),
                      AnimatedDefaultTextStyle(
                        style: currentDart() == 3 ?
                        TextStyle(
                          color: COLOR_MAIN_BLUE,
                          fontFamily: 'Portico',
                          letterSpacing: 0.5,
                          fontSize: 25,
                        ):
                        TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Portico',
                          letterSpacing: 0.5,
                          fontSize: 20,
                        ),
                        duration: Duration(milliseconds: 200),
                        child: Text(widget.currentPlayer.thirdDart != null ? widget.currentPlayer.thirdDart.toString() : '-',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(CustomIcons.three_darts),
                  Text(((widget.currentPlayer.firstDart != null ? widget.currentPlayer.firstDart : 0) + (widget.currentPlayer.secondDart != null ? widget.currentPlayer.secondDart : 0) + (widget.currentPlayer.thirdDart != null ? widget.currentPlayer.thirdDart : 0)).toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Portico',
                      letterSpacing: 0.5,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Text(AppLocalizations.of(context).average + widget.currentPlayer.average.toStringAsFixed(2),
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Portico',
                  letterSpacing: 0.5,
                  fontSize: 20,
                ),
              ),
              RaisedButton(
                child: Text(AppLocalizations.of(context).seeAll, style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Portico',
                  letterSpacing: 0.5,
                ),
                ),
                color: COLOR_MAIN_BLUE,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:  (context) => AlertDialog(
                      content: PlayerListXX1(key: Key('playersListXX1'), currentPlayer: widget.currentPlayer, players: widget.players, onUpdatePlayer:  widget.onUpdatePlayer,),
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