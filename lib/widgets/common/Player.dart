/* Object Player manipulate on all  game widget */
class Player {
  Player({this.name, this.score, this.firstDart, this.secondDart ,this.thirdDart, this.backward = false, this.round = 0,});
  String name;
  int score;
  int firstDart;
  int secondDart;
  int thirdDart;
  int round;
  bool backward;

  /* method call to reset player after each end game */
  void resetPlayer(int score) {
    this.score = score;
    this.firstDart = null;
    this.secondDart = null;
    this.thirdDart = null;
    this.round = 0;
  }
}
