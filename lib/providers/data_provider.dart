import 'dart:async';

import 'package:do_an_1_iot/data/device_data.dart';
import 'package:do_an_1_iot/models/device_model.dart';
import 'package:do_an_1_iot/models/home_model.dart';
import 'package:do_an_1_iot/models/room_model.dart';
import 'package:do_an_1_iot/models/user_model.dart';
import 'package:do_an_1_iot/services/auth_service.dart';
import 'package:do_an_1_iot/services/realtime_database_service.dart';
import 'package:do_an_1_iot/utils/id/id_generator.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  // --------- UserModel ---------------

  UserModel? _userModel;

  static const userPath = 'users';

  UserModel? get userModel => _userModel;

  // --------- HomeModel ---------------
  HomeModel? _selectedHome;

  HomeModel? get selectedHome => _selectedHome;

  List<HomeModel>? get homes => userModel?.homes;

  int? get indexSelectedHome {
    if (homes == null || selectedHome == null) {
      return null;
    }
    return homes!.indexOf(selectedHome!);
  }

  List<String>? get homeNames {
    if (homes != null) {
      return [for (var home in homes!) home.name];
    }
    return null;
  }

  void setSelectedHome(HomeModel homeModel) {
    _selectedHome = homeModel;

    notifyListeners();
  }
  // --------- RoomModel ---------------

  RoomModel? _selectedRoom;

  RoomModel? get selectedRoom => _selectedRoom;

  List<RoomModel>? get rooms {
    return selectedHome?.rooms;
  }

  int? get indexSelectedRoom {
    if (rooms == null || selectedRoom == null) {
      return null;
    }
    return homes!.indexOf(selectedHome!);
  }

  List<String>? get roomNames {
    if (rooms != null) {
      return [for (var room in rooms!) room.name];
    }
    return null;
  }

  void setSelectedRoom(RoomModel roomModel) {
    _selectedRoom = roomModel;

    notifyListeners();
  }

  // --------- Stream ---------------

  late StreamSubscription<DatabaseEvent> _dataStreamSubcription;

  StreamSubscription<DatabaseEvent> get dataStreamSubcription =>
      _dataStreamSubcription;

  Stream<DatabaseEvent> get userStream => RealtimeDatabaseService.databaseRef
      .child('$userPath/${AuthService.currentUser!.uid}')
      .onValue;

  // --------- Method ---------------
  void saveUserModel(String userName, String email) {
    final user = AuthService.currentUser;

    _userModel = UserModel(
      id: user!.uid,
      email: email,
      name: userName,
    );
  }

  Future<void> createHome(String homeName) async {
    final String userPath = DatabasePath.user(userModel!.id);

    final homeModel = HomeModel(id: IDGenerator.timeBasedID, name: homeName);

    await RealtimeDatabaseService.updateData(
        '$userPath/homes', homeModel.toJson());
  }

  Future<void> createRoom(String roomName) async {
    final String homePath = DatabasePath.home(userModel!.id, selectedHome!.id);

    final roomModel = RoomModel(id: IDGenerator.timeBasedID, name: roomName);

    await RealtimeDatabaseService.updateData(
        '$homePath/rooms', roomModel.toJson());
  }

  Future<void> createDevice(Device device) async {
    final String roomPath =
        DatabasePath.room(userModel!.id, selectedHome!.id, selectedRoom!.id);

    final deviceModel = DeviceModel(
        id: IDGenerator.timeBasedID, name: device.name, type: device.type);

    await RealtimeDatabaseService.updateData(
        '$roomPath/devices', deviceModel.toJson());
  }

  Future<void> updateDeviceData(
      String deviceId, Map<String, dynamic> data) async {
    final String path = DatabasePath.device(
        userModel!.id, selectedHome!.id, selectedRoom!.id, deviceId);
    print(path);
    await RealtimeDatabaseService.updateData(path, data);
  }

  Future<void> waitUntilDataComing() async {
    while (userModel == null) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  Future<void> startDataStreamSubcription() async {
    final currentUser = AuthService.currentUser;

    if (currentUser == null) return;

    _dataStreamSubcription = RealtimeDatabaseService.databaseRef
        .child('$userPath/${currentUser.uid}')
        .onValue
        .listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;

      _updateData(currentUser.uid, data);
    });
  }

  void _updateData(String id, Map<dynamic, dynamic> data) {
    _userModel = UserModel.fromDatabase(id, data);

    print(_userModel!.toJson());

    // Handle init data
    if (homes != null && _selectedHome == null) {
      setSelectedHome(homes!.first);
    }

    if (rooms != null && selectedRoom == null) {
      setSelectedRoom(rooms!.first);
    }

    // Update data when receive an event

    if (_selectedHome != null) {
      final homeModel =
          _userModel!.homes!.firstWhere((home) => home.id == _selectedHome!.id);
      setSelectedHome(homeModel);
    }

    if (_selectedRoom != null) {
      final roomModel = _selectedHome!.rooms!
          .firstWhere((room) => room.id == _selectedRoom!.id);
      setSelectedRoom(roomModel);
    }

    notifyListeners();
  }

  Future<void> cancelUserStreamSubcription() async {
    await _dataStreamSubcription.cancel();
  }
}
