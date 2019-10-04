import 'package:dartagnan/common/Player.dart';
import 'dart:convert';

/* Object Room uses to list connected group of players*/
class Room {
  Room({this.id, this.name, this.players,});
  int id;
  String name;
  List<Player> players;


  /* method call to transform response JSON to Player */
  factory Room.fromJson(Map<String, dynamic> json) {
    List<Player> players = [];
    for(var playerJson in json['players']) {
      players.add(Player.fromJson(playerJson));
    }
    return Room(
      id: json['room_id'],
      name: json['name'],
      players: players,
    );
  }
}