import 'room_model.dart';

class HomeModel {
  HomeModel({required this.id, required this.name, this.rooms});

  final String id;
  final String name;
  final List<RoomModel>? rooms;

  factory HomeModel.fromDatabase(String id, Map homeData) {
    List<RoomModel>? roomList;

    if (homeData['rooms'].isNotEmpty) {
      roomList = [];

      homeData['rooms'].forEach((id, roomData) {
        final roomModel = RoomModel.fromDatabase(id, roomData);

        roomList!.add(roomModel);
      });
    }

    return HomeModel(id: id, name: homeData['name'], rooms: roomList);
  }

  Map<String, dynamic> toJson() {
    Map? roomMap = {};

    if (rooms == null) {
      roomMap = null;
    } else {
      for (var room in rooms!) {
        roomMap.addAll(room.toJson());
      }
    }
    return {
      id: {
        'name': name,
        'rooms': roomMap ?? '',
      }
    };
  }
}
