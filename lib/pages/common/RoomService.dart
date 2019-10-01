import 'Room.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RoomService {
  Future<List<Room>> fetchRooms() async {
    final response =
    await http.get('http://marais.tk:8080/rooms');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
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
}