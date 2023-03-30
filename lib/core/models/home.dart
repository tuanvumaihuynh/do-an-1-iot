import 'package:do_an_1_iot/core/models/room.dart';

class Home {
  Home({
    required this.id,
    required this.name,
    required this.room,
  });

  final String id;
  final String name;
  final List<Room>? room;

  factory Home.fromRTDB(Map<String, dynamic> data, String id) {
    final List<Room> roomList = [];
    if (data["room"] != "") {
      data["room"].forEach((key, value) {
        roomList.add(Room.fromRTDB(
            Map<String, dynamic>.from(value as Map<dynamic, dynamic>), key));
      });
    }
    return Home(
      id: id,
      name: data['name'],
      room: roomList,
    );
  }

  Map<String, dynamic> toJson() => {
        // "id": id,
        "name": name,
        "room": room != [] && room != null
            ? {for (var ele in room!) ele.id: ele.toJson()}
            : '',
      };
}
