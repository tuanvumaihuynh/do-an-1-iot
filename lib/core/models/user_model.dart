class UserModel {
  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.photoUrl,
      required this.phoneNumber,
      required this.homeIDs});

  final String id;
  final String email;
  final String? photoUrl;
  final String name;
  final String? phoneNumber;
  final List<String> homeIDs;

  factory UserModel.fromRTDB(Map<String, dynamic> data, String id) => UserModel(
        id: id,
        name: data['name'],
        email: data['email'],
        photoUrl: data['photoUrl'],
        phoneNumber: data['phoneNumber'],
        homeIDs: data['homeIDs'] != ''
            ? [for (var ele in data['homeIDs'].entries) ele.key]
            : [],
      );

  Map<String, dynamic> toJson() => {
        //! Don't push id to rtdb because key head contains user id
        // "id": id,
        "name": name,
        "email": email,
        "photoUrl": photoUrl,
        "phoneNumber": phoneNumber,
        "homeIDs":
            homeIDs != [] ? {for (var homeID in homeIDs) homeID: true} : '',
      };
}
