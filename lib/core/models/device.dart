class Device {
  Device({
    this.state = false,
    required this.id,
    required this.name,
    this.type = "device",
    this.image = "assets/images/device-96.png",
  });
  final String id;
  final String name;
  final String image;
  final String type;
  final bool state;

  factory Device.fromRTDB(Map<String, dynamic> json, String id) => Device(
        id: id,
        name: json['name'],
        type: json['type'],
        state: json['state'],
      );
  Map<String, dynamic> toJson() => {
        id: {
          'name': name,
          'type': type,
          'state': state,
        }
      };
}

class Fan extends Device {
  Fan({
    required super.id,
    required super.name,
    super.type = "fan",
    super.state,
    this.value = 0,
    super.image = "assets/images/fan-96.png",
  });
  final int value;

  factory Fan.fromRTDB(Map<String, dynamic> json, String id) => Fan(
        id: id,
        name: json['name'],
        type: "fan",
        state: json['state'],
        value: json['value'],
        image: "assets/images/fan-96.png",
      );
  @override
  Map<String, dynamic> toJson() => {
        id: {
          'name': name,
          'type': type,
          'state': state,
          'value': value,
        }
      };
}

class Led extends Device {
  Led({
    required super.id,
    required super.name,
    super.type = "led",
    super.state,
    super.image = "assets/images/bulb-96.png",
  });

  factory Led.fromRTDB(Map<String, dynamic> json, String id) => Led(
        id: id,
        name: json['name'],
        type: "led",
        state: json['state'],
        image: "assets/images/bulb-96.png",
      );
  @override
  Map<String, dynamic> toJson() => {
        id: {
          'name': name,
          'type': type,
          'state': state,
        }
      };
}

/// State property always true
class HumidAndTempSensor extends Device {
  HumidAndTempSensor({
    required super.id,
    required super.name,
    super.type = "dht11",
    this.temperature = 30,
    this.humidity = 70,
    super.state = true,
  });
  final double humidity;
  final double temperature;

  factory HumidAndTempSensor.fromRTDB(Map<String, dynamic> json, String id) =>
      HumidAndTempSensor(
        id: id,
        name: json['name'],
        type: json['type'],
        temperature: json['temperature'],
        humidity: json['humidity'],
        state: json['state'],
      );
  @override
  Map<String, dynamic> toJson() => {
        id: {
          'name': name,
          'type': type,
          'temperature': temperature,
          'humidity': humidity,
          'state': state,
        }
      };
}

class SuperLed extends Device {
  SuperLed({
    required super.id,
    required super.name,
    super.type = "super led",
    this.mode = 1,
    super.state,
  });
  final int mode;

  factory SuperLed.fromRTDB(Map<String, dynamic> json, String id) => SuperLed(
        id: id,
        name: json['name'],
        type: json['type'],
        mode: json['mode'],
        state: json['state'],
      );
  @override
  Map<String, dynamic> toJson() => {
        id: {
          'name': name,
          'type': type,
          'mode': mode,
          'state': state,
        }
      };
}
