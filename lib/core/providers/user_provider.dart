import 'dart:async';
import 'package:do_an_1_iot/core/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? _userModel;
  static var currentUser = FirebaseAuth.instance.currentUser;

  final _realTimeDBRef = FirebaseDatabase.instance.ref();

  static const USER_PATH = 'users';

  UserModel? get userModel => _userModel;
  StreamSubscription<DatabaseEvent> get userStreamSubcription =>
      _userModelStreamSub;
  late StreamSubscription<DatabaseEvent> _userModelStreamSub;

  Future<void> listenToUserModel() async {
    print('START: listen to user model');
    await currentUser!.reload();
    currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser);

    _userModelStreamSub = _realTimeDBRef
        .child(USER_PATH)
        .child(currentUser!.uid)
        .onValue
        .listen((event) {
      _userModel = UserModel.fromRTDB(
          Map<String, dynamic>.from(
              event.snapshot.value as Map<dynamic, dynamic>),
          currentUser!.uid);

      print('Listen to user model ${_userModel?.toJson()}');
      notifyListeners();
    });
  }

  Future<void> fetchAndSetUserData() async {
    await currentUser!.reload();
    currentUser = FirebaseAuth.instance.currentUser;
    final snapshot =
        await _realTimeDBRef.child(USER_PATH).child(currentUser!.uid).get();
    if (snapshot.exists) {
      _userModel = UserModel.fromRTDB(
          Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>),
          currentUser!.uid);
    }
  }

  Future cancelSub() async {
    await userStreamSubcription.cancel();
  }
}
