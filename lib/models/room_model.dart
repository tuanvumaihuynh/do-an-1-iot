import 'device_model.dart';

class RoomModel {
  RoomModel({required this.id, required this.name, this.devices});

  final String id;
  final String name;
  final List<DeviceModel>? devices;

  factory RoomModel.fromDatabase(String id, Map roomData) {
    List<DeviceModel>? deviceList;

    if (roomData['devices'].isNotEmpty) {
      deviceList = [];

      roomData['devices'].forEach((id, deviceData) {
        final deviceModel = getDeviceBasedOnType(id, deviceData);

        deviceList!.add(deviceModel);
      });
    }

    return RoomModel(id: id, name: roomData['name'], devices: deviceList);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic>? deviceMap;

    if (devices != null) {
      deviceMap = {};

      for (var device in devices!) {
        deviceMap.addAll(device.toJson());
      }
    }
    return {
      id: {
        'name': name,
        'devices': deviceMap ?? '',
      }
    };
  }
}

DeviceModel getDeviceBasedOnType(String id, Map deviceData) {
  switch (deviceData['type']) {
    case 'light':
      return Light.fromDatabase(id, deviceData);
    case 'fan':
      return Fan.fromDatabase(id, deviceData);
    case 'door_lock':
      return DoorLock.fromDatabase(id, deviceData);
    case 'AC':
      return AirConditioner.fromDatabase(id, deviceData);
    default:
      return DeviceModel.fromDatabase(id, deviceData);
  }
}
