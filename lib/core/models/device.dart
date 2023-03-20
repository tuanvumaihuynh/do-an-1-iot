class Device {
  Device(
      {required this.state,
      required this.id,
      required this.name,
      required this.type});
  final String id;
  final String name;
  final String type;
  final bool state;

  factory Device.fromMap(Map<String, dynamic> json) => Device(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        state: json['state'],
      );
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'type': type,
        'state': state,
      };
}

class Fan extends Device {
  Fan({
    required super.id,
    required super.name,
    required super.type,
    required super.state,
    required this.value,
  });
  final int value;

  factory Fan.fromMap(Map<String, dynamic> json) => Fan(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        state: json['state'],
        value: json['value'],
      );
  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'type': type,
        'state': state,
        'value': value,
      };
}

class Led extends Device {
  Led({
    required super.id,
    required super.name,
    required super.type,
    required super.state,
  });

  factory Led.fromMap(Map<String, dynamic> json) => Led(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        state: json['state'],
      );
  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'type': type,
        'state': state,
      };
}

/// State property always true
class HumidAndTempSensor extends Device {
  HumidAndTempSensor({
    required super.id,
    required super.name,
    required super.type,
    required this.temperature,
    required this.humidity,
    super.state = true,
  });
  final double humidity;
  final double temperature;

  factory HumidAndTempSensor.fromMap(Map<String, dynamic> json) =>
      HumidAndTempSensor(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        temperature: json['temperature'],
        humidity: json['humidity'],
        state: json['state'],
      );
  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'type': type,
        'temperature': temperature,
        'humidity': humidity,
        'state': state,
      };
}

class SuperLed extends Device {
  SuperLed({
    required super.id,
    required super.name,
    required super.type,
    required this.mode,
    required super.state,
  });
  final int mode;

  factory SuperLed.fromMap(Map<String, dynamic> json) => SuperLed(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        mode: json['mode'],
        state: json['state'],
      );
  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'type': type,
        'mode': mode,
        'state': state,
      };
}
