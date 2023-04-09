import 'package:do_an_1_iot/core/models/device_model.dart';

class Room {
  Room({
    required this.id,
    required this.name,
    required this.device,
  });
  final String id;
  final String name;
  final List<Device>? device;

  factory Room.fromRTDB(Map<String, dynamic> data, String id) {
    final List<Device> deviceList = [];
    if (data["device"] != "") {
      data["device"].forEach((key, value) {
        final deviceData =
            Map<String, dynamic>.from(value as Map<dynamic, dynamic>);
        final device = exportDevice(key, deviceData);
        deviceList.add(device);
      });
    }
    return Room(
      id: id,
      name: data['name'],
      device: deviceList,
    );
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        // 'id': id,
        'device': device != [] && device != null
            ? {for (var ele in device!) ele.id: ele.toJson()}
            : '',
      };
}

Device exportDevice(String key, Map<String, dynamic> value) {
  switch (value["type"]) {
    case "led":
      return Led.fromRTDB(value, key);
    case "fan":
      return Fan.fromRTDB(value, key);
    case "dht11":
      return HumidAndTempSensor.fromRTDB(value, key);
    case "door_lock":
      return DoorLock.fromRTDB(value, key);
    default:
      return SuperLed.fromRTDB(value, key);
  }
}
