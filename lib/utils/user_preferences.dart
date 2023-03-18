// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:do_an_1_iot/core/models/user_model.dart';

// class UserPreferences {
//   static late SharedPreferences _preferences;

//   static const _keyUser = 'user';

//   static Future init() async =>
//       _preferences = await SharedPreferences.getInstance();

//   static final userDefault = UserModel(
//       displayName: '',
//       email: '',
//       uid: '',
//       avatarUrl:
//           'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
//       roomList: null);

//   static Future setUser(UserModel userModel) async {
//     final json = jsonEncode(userModel.toJson());

//     await _preferences.setString(_keyUser, json);
//   }

//   static UserModel? getUser() {
//     final json = _preferences.getString(_keyUser);

//     return json == null ? null : UserModel.fromRTDB(jsonDecode(json));
//   }

//   static removeUser() {
//     _preferences.remove(_keyUser);
//   }
// }
