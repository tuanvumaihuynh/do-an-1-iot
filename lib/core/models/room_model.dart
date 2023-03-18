import 'package:do_an_1_iot/core/models/device_model.dart';

class RoomModel {
  RoomModel({required this.deviceList});
  final List<DeviceModel> deviceList;

  factory RoomModel.fromMap(Map<String, dynamic> json) =>
      RoomModel(deviceList: json['devices']);

  Map<String, dynamic> toMap() => {
        "devices":
            List.from(deviceList.map((deviceModel) => deviceModel.toMap()))
      };
}
