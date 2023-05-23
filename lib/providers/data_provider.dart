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
  static const userPath = 'users';

  UserModel? _userModel;
  HomeModel? _selectedHome;
  RoomModel? _selectedRoom;
  DeviceModel? _selectedDevice;
  List<RoomModel>? rooms;
  late StreamSubscription<DatabaseEvent> _dataStreamSubcription;

  UserModel? get userModel => _userModel;
  HomeModel? get selectedHome => _selectedHome;
  RoomModel? get selectedRoom => _selectedRoom;
  DeviceModel? get selectedDevice => _selectedDevice;

  List<HomeModel>? get homes => userModel?.homes;

  int? get indexSelectedHome => homes?.indexOf(selectedHome!);
  int? get indexSelectedRoom => homes?.indexOf(selectedHome!);

  List<String>? get homeNames => homes?.map((home) => home.name).toList();
  List<String>? get roomNames => rooms?.map((room) => room.name).toList();

  StreamSubscription<DatabaseEvent> get dataStreamSubcription =>
      _dataStreamSubcription;

  Stream<DatabaseEvent> get userStream => RealtimeDatabaseService.databaseRef
      .child('$userPath/${AuthService.currentUser!.uid}')
      .onValue;

  void setSelectedHome(HomeModel homeModel) {
    _selectedHome = homeModel;
    rooms = homeModel.rooms;
    notifyListeners();
  }

  void setSelectedRoom(RoomModel? roomModel) {
    _selectedRoom = roomModel;
    notifyListeners();
  }

  void setSelectedDevice(DeviceModel? deviceModel) {
    _selectedDevice = deviceModel;
    notifyListeners();
  }

  /// This method only uses when sign up
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

  void clearUserData() {
    _userModel = null;
    _selectedHome = null;
    _selectedRoom = null;
    rooms = null;
  }
}
