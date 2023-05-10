import 'package:do_an_1_iot/models/home_model.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.phoneNumber,
    this.photoUrl,
    this.homes,
  });
  String id;
  String email;
  String name;
  String? phoneNumber;
  String? photoUrl;
  List<HomeModel>? homes;

  factory UserModel.fromDatabase(String id, Map userData) {
    List<HomeModel>? homeList;

    if (userData['homes'].isNotEmpty) {
      homeList = [];

      userData['homes'].forEach((id, homeData) {
        final homeModel = HomeModel.fromDatabase(id, homeData);

        homeList!.add(homeModel);
      });
    }

    return UserModel(
      id: id,
      name: userData['name'],
      email: userData['email'],
      phoneNumber: userData['phone_number'],
      photoUrl: userData['photo_url'],
      homes: homeList,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic>? homeMap;

    if (homes != null) {
      homeMap = {};

      for (var home in homes!) {
        homeMap.addAll(home.toJson());
      }
    }

    return {
      id: {
        'name': name,
        'email': email,
        'phone_number': phoneNumber ?? '',
        'photo_url': photoUrl ?? '',
        'homes': homeMap ?? ''
      }
    };
  }
}
