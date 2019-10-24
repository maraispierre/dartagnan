
import 'package:dartagnan/common/Player.dart';

/* Class use for save historical state of cricket game */
class StateHistorical extends Player{
  StateHistorical({this.score, this.tableCricket, this.firstDart, this.secondDart, this.thirdDart});
  int score;
  Map<int, int> tableCricket;
  int firstDart;
  int secondDart;
  int thirdDart;
}