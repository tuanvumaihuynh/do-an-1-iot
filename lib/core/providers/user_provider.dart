import 'dart:async';
import 'package:do_an_1_iot/core/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  UserModel? get userModel => _user;

  final _realTimeDBRef = FirebaseDatabase.instance.ref();

  StreamSubscription<DatabaseEvent> get userStreamSubcription =>
      _userModelStreamSub;
  late StreamSubscription<DatabaseEvent> _userModelStreamSub;

  static var currentUser = FirebaseAuth.instance.currentUser;
  static late List<String> homeIDs;
  static const USER_PATH = 'users';

  /// Start listening to changes in the user data stored in the Firebase Realtime Database.
  ///
  /// When the data changes, it updates the `_user` and `homeIDs` variables and
  /// notifies any listeners that the user data has changed.
  Future<void> startListeningToUserChangesInRTDB() async {
    // print('START: listen to user model');

    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) return;
    await currentUser.reload();

    _userModelStreamSub = _realTimeDBRef
        .child(USER_PATH)
        .child(currentUser.uid)
        .onValue
        .listen((event) {
      _user = UserModel.fromRTDB(
          Map<String, dynamic>.from(
              event.snapshot.value as Map<dynamic, dynamic>),
          currentUser.uid);

      // print('Listen to user model ${_user?.toJson()}');
      homeIDs = _user!.homeIDs;

      notifyListeners();
    });
  }

  /// Load the current user data from the Firebase Realtime Database and update the `_user`
  /// and `homeIDs` variables. Does nothing if there is no current user.
  Future<void> loadCurrentUserFromDB() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) return;
    await currentUser.reload();

    final snapshot =
        await _realTimeDBRef.child(USER_PATH).child(currentUser.uid).get();

    if (snapshot.exists) {
      _user = UserModel.fromRTDB(
          Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>),
          currentUser.uid);

      homeIDs = _user!.homeIDs;
    }
  }

  /// Cancels the subscription to the user stream.
  ///
  /// This function cancels the stream subscription created by `startListeningToUserChangesInRTDB()`.
  /// It is important to call this function when the stream subscription is no longer needed to prevent memory leaks.
  ///
  /// Example:
  ///
  /// ```dart
  /// UserProvider userProvider = context.read<HomeProvider>();
  /// userProvider.startListeningToUserChangesInRTDB();
  /// // ...
  /// userProvider.cancelStreamSubcription();
  /// ```
  Future<void> cancelStreamSubcription() async {
    await userStreamSubcription.cancel();
  }
}
