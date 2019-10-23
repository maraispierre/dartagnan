import '../common/Room.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dartagnan/services/SignInService.dart';
import 'package:crypt/crypt.dart';

class RoomService {

  //static final url = 'http://marais.tk:8080';
  static final url = 'http://localhost:8080';

  Future<List<Room>> fetchRooms() async {
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"userId": "' + new Crypt.sha256(SignInService.email, rounds: 10000, salt:"abcdefghijklmnop").hash+ '"}';
    final response =
    await http.post(url +'/rooms', headers: headers, body: json);

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
    String json = '{"name": "' + nameRoom + '", "userId": "' + new Crypt.sha256(SignInService.email, rounds: 10000, salt:"abcdefghijklmnop").hash + '"}';
    final response =
    await http.post(url + '/room', headers: headers, body: json);

    if (response.statusCode == 200) {
      return Room.fromJson(jsonDecode(response.body));  
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to create room');
    }
  }

  Future<Room> updateRoom(Room room) async {
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = generateRoomJson(room);
    final response =
    await http.put(url + '/room', headers: headers, body: json);

    if (response.statusCode == 200) {
      return Room.fromJson(jsonDecode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to create room');
    }
  }

  String generateRoomJson(Room room) {
    String json = jsonEncode(room);
    return json;
  }

  Future<Room> deleteRoom(Room room) async {
    final response =
    await http.delete(url + '/room/' + room.id.toString());

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
    await http.post(url + '/room/' + room.id.toString() + '/player', headers: headers, body: json);

    if (response.statusCode == 200) {
      return Room.fromJson(jsonDecode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to add player');
    }
  }

  Future<Room> removeUser(Room room, int playerId) async {
    final response =
    await http.delete(url + '/room/' + room.id.toString() + '/player/' + playerId.toString());

    if (response.statusCode == 200) {
      return Room.fromJson(jsonDecode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to remove player');
    }
  }
}
