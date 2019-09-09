import 'package:flutter_dart_score/widgets/common/Player.dart';

/* Object Player manipulate on all XX1 game widget */
class PlayerXX1 extends Player{
  PlayerXX1({name, score, firstDart, secondDart ,thirdDart, backward = false, round = 0, this.average = 0.0, this.totalScore = 0,}) : super(name: name, score: score, firstDart: firstDart, secondDart: secondDart, thirdDart: thirdDart, backward: backward, round: round);
  double average;
  int totalScore;

  @override
  /* method call to reset player after each end game */
  void resetPlayer(int score) {
    super.resetPlayer(score);
    this.totalScore = 0;
    this.average = 0;
  }
}
