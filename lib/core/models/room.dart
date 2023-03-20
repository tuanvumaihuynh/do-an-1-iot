import 'package:do_an_1_iot/core/models/device.dart';

class Room {
  Room({
    required this.id,
    required this.name,
    required this.deviceIDs,
  });
  final String id;
  final String name;
  final List<String>? deviceIDs;

  factory Room.fromMap(Map<String, dynamic> data) => Room(
        id: data['id'],
        name: data['name'],
        deviceIDs: data['deviceIDs'].entries.map((entry) => entry.key).toList(),
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'id': id,
        'deviceList': deviceIDs != null
            ? {for (var deviceID in deviceIDs!) deviceID: true}
            : {},
      };
}
