import 'package:dartagnan/common/Player.dart';
import 'dart:convert';

/* Object Room uses to list connected group of players*/
class Room {
  Room({this.id, this.name, this.players, this.userId});
  int id;
  String name;
  String userId;
  List<Player> players;


  /* method call to transform response JSON to Player */
  factory Room.fromJson(Map<String, dynamic> json) {
    List<Player> players = [];
    for(var playerJson in json['players']) {
      players.add(Player.fromJson(playerJson));
    }
    return Room(
      id: json['roomId'],
      name: json['name'],
      userId: json['userId'],
      players: players,
    );
  }


  Map<String, dynamic> toJson() => {
    'roomId' : id,
    'userId' : userId,
    'name' : name,
    'players' : players
  };
}