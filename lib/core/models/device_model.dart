class DeviceModel {
  DeviceModel({required this.name, required this.status});
  final String name;
  final bool status;

  factory DeviceModel.fromMap(Map<String, dynamic> json) =>
      DeviceModel(name: json['name'], status: json['status']);

  Map<String, dynamic> toMap() => {'name': name, 'status': status};
}
