import 'package:do_an_1_iot/core/models/room_model.dart';

class HomeModel {
  HomeModel({
    required this.id,
    required this.name,
    required this.room,
  });

  final String id;
  final String name;
  final List<Room>? room;

  factory HomeModel.fromRTDB(Map<String, dynamic> data, String id) {
    final List<Room> roomList = [];
    if (data["room"] != "") {
      data["room"].forEach((key, value) {
        roomList.add(Room.fromRTDB(
            Map<String, dynamic>.from(value as Map<dynamic, dynamic>), key));
      });
    }
    return HomeModel(
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
