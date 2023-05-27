class DeviceModel {
  DeviceModel(
      {required this.id,
      required this.name,
      this.state = false,
      this.type = 'device'});
  final String id;
  final String name;
  final String type;
  final bool state;

  factory DeviceModel.fromDatabase(String id, Map deviceData) {
    return DeviceModel(
        id: id, name: deviceData['name'], state: deviceData['state']);
  }

  Map<String, dynamic> toJson() => {
        id: {'name': name, 'state': state, 'type': type}
      };

  String get imagePath => 'assets/images/$type.png';
}

class Light extends DeviceModel {
  Light({required id, required name, required state, super.type})
      : super(id: id, name: name, state: state);

  factory Light.fromDatabase(String id, Map deviceData) {
    return Light(
        id: id,
        name: deviceData['name'],
        state: deviceData['state'],
        type: deviceData['type']);
  }

  @override
  Map<String, dynamic> toJson() => {
        id: {'name': name, 'type': type, 'state': state}
      };
}

class Fan extends DeviceModel {
  Fan({required id, required name, required state, super.type})
      : super(id: id, name: name, state: state);

  factory Fan.fromDatabase(String id, Map deviceData) {
    return Fan(
        id: id,
        name: deviceData['name'],
        state: deviceData['state'],
        type: deviceData['type']);
  }

  @override
  Map<String, dynamic> toJson() => {
        id: {'name': name, 'type': type, 'state': state}
      };
}

class DoorLock extends DeviceModel {
  DoorLock({required id, required name, required state, super.type})
      : super(
          id: id,
          name: name,
          state: state,
        );

  factory DoorLock.fromDatabase(String id, Map deviceData) {
    return DoorLock(
        id: id,
        name: deviceData['name'],
        state: deviceData['state'],
        type: deviceData['type']);
  }

  @override
  Map<String, dynamic> toJson() => {
        id: {'name': name, 'type': type, 'state': state}
      };
}

class AirConditioner extends DeviceModel {
  AirConditioner(
      {required id,
      required name,
      required state,
      super.type,
      required this.humidity,
      required this.temperature})
      : super(
          id: id,
          name: name,
          state: state,
        );

  int temperature;
  int humidity;

  factory AirConditioner.fromDatabase(String id, Map deviceData) {
    return AirConditioner(
        id: id,
        name: deviceData['name'],
        state: deviceData['state'],
        temperature: deviceData['temperature'],
        humidity: deviceData['humidity'],
        type: deviceData['type']);
  }

  @override
  Map<String, dynamic> toJson() => {
        id: {
          'name': name,
          'type': type,
          'state': state,
          'temperature': temperature,
          'humidity': humidity
        }
      };
}
