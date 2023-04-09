import 'dart:async';

import 'package:do_an_1_iot/core/models/device_model.dart';
import 'package:do_an_1_iot/core/models/home_model.dart';
import 'package:do_an_1_iot/core/models/room_model.dart';
import 'package:do_an_1_iot/core/providers/user_provider.dart';
import 'package:do_an_1_iot/core/services/unique_id_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  final List<HomeModel> _homeList = [];
  int indexSelectedhome = 0;
  late HomeModel _selectedHome;
  final homeIDList = UserProvider.homeIDs;
  final _realTimeDBRef = FirebaseDatabase.instance.ref();

  static const HOME_PATH = 'homes';
  static List<List<String>?>? roomIDList;

  HomeModel get selectedHome => _selectedHome;

  List<HomeModel>? get homeList => _homeList;

  StreamSubscription<DatabaseEvent>? get homeStreamSubcription =>
      _homeStreamSubciption;
  late StreamSubscription<DatabaseEvent>? _homeStreamSubciption;

  void setIndexSelectedHome(int index) {
    indexSelectedhome = index;
    _selectedHome = _homeList[index];
    notifyListeners();
  }

  /// Fetch parallel
  Future<void> fetchHomeData() async {
    // Reset home list and home ID List when fetch
    final homeIDList = UserProvider.homeIDs;

    _homeList.clear();

    final futures = <Future>[];
    for (var homeID in homeIDList) {
      futures.add(_realTimeDBRef.child(HOME_PATH).child(homeID).once());
    }

    final results = await Future.wait(futures);

    for (var databaseEvent in results) {
      if (databaseEvent.snapshot.exists) {
        var home = HomeModel.fromRTDB(
          Map<String, dynamic>.from(
              databaseEvent.snapshot.value as Map<dynamic, dynamic>),
          databaseEvent.snapshot.key,
        );
        _homeList.add(home);
      }
    }

    _selectedHome = homeList![indexSelectedhome];

    notifyListeners();
  }

  List<Room>? getRoomList(String homeID) {
    //! Check Or else null when find nothing
    final home = _homeList.firstWhere((home) => home.id == homeID);
    return home.room;
  }

  Future<void> startListeningToHomeChangesInRTDB() async {
    // print('START: listen to this home: ${selectedHome.name}');

    _homeStreamSubciption = _realTimeDBRef
        .child(HOME_PATH)
        .child(selectedHome.id)
        .onValue
        .listen((dataBaseEvent) {
      _selectedHome = HomeModel.fromRTDB(
          Map<String, dynamic>.from(
              dataBaseEvent.snapshot.value as Map<dynamic, dynamic>),
          selectedHome.id);
      // print('Listen to Home ${selectedHome.toJson()}');

      notifyListeners();
    });
  }

  Future<void> cancelHomeStreamSubcription() async {
    if (_homeStreamSubciption != null) {
      await _homeStreamSubciption!.cancel().then(
        (value) {
          _homeStreamSubciption = null;
        },
      );
    }
  }

  Future<void> updateStateDevice(
      bool state, String deviceID, String roomID) async {
    await _realTimeDBRef
        .child(HOME_PATH)
        .child(selectedHome.id)
        .child("room")
        .child(roomID)
        .child("device")
        .child(deviceID)
        .update({"state": state});
  }

  Future<void> pushDeviceDataIntoRTDB(
      String roomID, Map<String, dynamic> json) async {
    await _realTimeDBRef
        .child(HOME_PATH)
        .child(selectedHome.id)
        .child("room")
        .child(roomID)
        .child("device")
        .update(json);
  }

  Map<String, dynamic> createDeviceJson(String type, String deviceName) {
    final id = UniqueIDService.timeBasedID;
    switch (type) {
      case "led":
        return Led(id: id, name: deviceName).toJson();
      case "fan":
        return Fan(id: id, name: deviceName).toJson();
      case "dht11":
        return HumidAndTempSensor(id: id, name: deviceName).toJson();
      case "door_lock":
        return DoorLock(id: id, name: deviceName).toJson();
      default:
        return SuperLed(id: id, name: deviceName).toJson();
    }
  }
}
