/* Object Player manipulate on all  game widget */
class Player {
  Player({this.id, this.name, this.score, this.firstDart, this.secondDart ,this.thirdDart, this.backward = false, this.round = 0,});
  int id;
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


  /* method call to transform response JSON to Player */
  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['playerId'],
      name: json['name'],
    );
  }
}
