import 'package:dartagnan/pages/cricket/widgets/StateHistorical.dart';

/* Object Player manipulate on all  game widget */
class Player {
  Player({this.id, this.name, this.score, this.firstDart, this.secondDart ,this.thirdDart, this.backward = false, this.round = 0, this.numberGame = 0, this.numberWonGame = 0, this.totalScore = 0, this.totalRounds = 0, this.average = 0.0, this.totalScoreGame = 0, this.tableCricket});

  //common variable
  int id;
  String name;
  int score;
  int firstDart;
  int secondDart;
  int thirdDart;
  int round;
  bool backward;
  int numberGame;
  int numberWonGame;
  int totalScore;
  int totalRounds;


  //xx1 variable
  double average;
  int totalScoreGame;

  //cricket variable

  Map<int, int> tableCricket;
  List<StateHistorical> historical = [];

  /* method call to reset player after each end game */
  void resetPlayer(int score) {
    this.score = score;
    this.firstDart = null;
    this.secondDart = null;
    this.thirdDart = null;
    this.round = 0;

    //xx1
    this.totalScoreGame = 0;
    this.average = 0;

    //cricket
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

  void updateStatsXx1() {
    this.totalScore+= totalScoreGame;
    this.totalRounds+= round;
    this.numberGame++;
  }

  void updateStatsCricket() {
    this.numberGame++;
  }


  /* method call to transform response JSON to Player */
  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['playerId'],
      name: json['name'],
      numberGame: json['numberGame'],
      numberWonGame: json['numberWonGame'],
      totalScore: json['totalScore'],
      totalRounds: json['totalRounds']
    );
  }

  Map<String, dynamic> toJson() => {
    'playerId' : id,
    'name' : name,
    'numberGame' : numberGame,
    'numberWonGame' : numberWonGame,
    'totalScore': totalScore,
    'totalRounds': totalRounds
  };
}
