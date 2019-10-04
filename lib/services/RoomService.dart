import '../common/Room.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dartagnan/services/SignInService.dart';

class RoomService {
  Future<List<Room>> fetchRooms() async {
    final response =
    await http.get('http://marais.tk:8080/rooms/' + email);

    if (response.statusCode == 200) {
      List<Room> rooms = [];
      for(var roomJson in jsonDecode(response.body)) {
        rooms.add(Room.fromJson(roomJson));
      }
      return rooms;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load rooms');
    }
  }

  Future<Room> createRoom(String nameRoom) async {
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"name": "' + nameRoom + '", "userId": "' + email + '"}';
    final response =
    await http.post('http://marais.tk:8080/room', headers: headers, body: json);

    if (response.statusCode == 200) {
      return Room.fromJson(jsonDecode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to create room');
    }
  }

  Future<Room> deleteRoom(Room room) async {
    final response =
    await http.delete('http://marais.tk:8080/room/' + room.id.toString());

    if (response.statusCode == 200) {
      return Room.fromJson(jsonDecode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to delete room');
    }
  }

  Future<Room> addUser(Room room, String playerName) async {
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"name": "' + playerName + '"}';
    final response =
    await http.post('http://marais.tk:8080/room/' + room.id.toString() + '/player', headers: headers, body: json);

    if (response.statusCode == 200) {
      return Room.fromJson(jsonDecode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to add player');
    }
  }

  Future<Room> removeUser(Room room, int playerId) async {
    final response =
    await http.delete('http://marais.tk:8080/room/' + room.id.toString() + '/player/' + playerId.toString());

    if (response.statusCode == 200) {
      return Room.fromJson(jsonDecode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to remove player');
    }
  }
}
