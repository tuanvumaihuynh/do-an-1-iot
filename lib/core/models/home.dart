import 'package:do_an_1_iot/core/models/room.dart';

class Home {
  Home({
    required this.id,
    required this.name,
    required this.roomIDs,
  });

  final String id;
  final String name;
  final List<String>? roomIDs;

  factory Home.fromRTDB(Map<String, dynamic> data) => Home(
        id: data['id'],
        name: data['name'],
        roomIDs: data['roomIDs'].entries.map((entry) => entry.key).toList(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": name,
        "roomIDs":
            roomIDs != null ? {for (var roomID in roomIDs!) roomID: true} : {},
      };
}
