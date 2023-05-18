class Device {
  Device({required this.name, required this.type});
  final String name;
  final String type;

  String get imagePath => 'assets/images/$type.png';
}

class DeviceData {
  static Map<String, List<Device>> devices = {
    'Air treatment device': airTreatmentDevices,
    'Lighting device': lightingDevices,
    'Household security device': houseHoldSecurityDevices
  };

  static List<Device> lightingDevices = [
    Device(name: 'Smart Bulb', type: 'light'),
    // Device(name: 'Ceiling Light', type: 'ceiling_light')
  ];

  static List<Device> airTreatmentDevices = [
    Device(name: 'Fan', type: 'fan'),
    // Device(name: 'Air Purifier', type: 'air_purifier')
  ];

  static List<Device> houseHoldSecurityDevices = [
    Device(name: 'Door Lock', type: 'door_lock'),
    // Device(name: 'Video Camera', type: 'video_camera')
  ];
}
