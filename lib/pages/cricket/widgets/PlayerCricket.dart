import 'package:dartagnan/common/Player.dart';
import 'StateHistorical.dart';
/* Object Player manipulate on all Cricket game widget */
class PlayerCricket extends Player{
  PlayerCricket({name, score, firstDart, secondDart ,thirdDart, backward = false, round = 0, this.tableCricket,}) : super(name: name, score: score, firstDart: firstDart, secondDart: secondDart, thirdDart: thirdDart, backward: backward, round: round);
  Map<int, int> tableCricket;
  List<StateHistorical> historical = [];

  @override
  /* method call to reset player after each end game */
  void resetPlayer(int score) {
    super.resetPlayer(score);
    this.tableCricket = new Map();
    this.tableCricket[15] = 0;
    this.tableCricket[16] = 0;
    this.tableCricket[17] = 0;
    this.tableCricket[18] = 0;
    this.tableCricket[19] = 0;
    this.tableCricket[20] = 0;
    this.tableCricket[25] = 0;
    this.historical = [];
  }
}
