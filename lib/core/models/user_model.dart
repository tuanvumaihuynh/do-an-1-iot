import 'package:do_an_1_iot/core/models/room_model.dart';

class UserModel {
  UserModel(
      {required this.uid,
      required this.displayName,
      required this.email,
      required this.avatarUrl,
      required this.roomList});

  final String uid;
  final String email;
  final String? avatarUrl;
  final String displayName;
  final List<RoomModel>? roomList;

  factory UserModel.fromRTDB(Map<String, dynamic> data) => UserModel(
        displayName: data["displayName"],
        uid: data["uid"],
        email: data["email"],
        avatarUrl: data["photoUrl"],
        roomList: data['rooms'] != ""
            ? List<RoomModel>.from(
                data['rooms'].map((roomModel) => RoomModel.fromMap(roomModel)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "uid": uid,
        "email": email,
        "photoUrl": avatarUrl ?? '',
        "rooms": roomList != null
            ? List.from(roomList!.map((roomModel) => roomModel.toMap()))
            : "",
      };
}
