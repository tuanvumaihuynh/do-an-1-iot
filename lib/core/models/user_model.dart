class UserModel {
  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.photoUrl,
      required this.homeIDs});

  final String id;
  final String email;
  final String? photoUrl;
  final String name;
  final List<String>? homeIDs;

  factory UserModel.fromRTDB(Map<String, dynamic> data, String id) => UserModel(
        id: id,
        name: data['name'],
        email: data['email'],
        photoUrl: data['photoUrl'],
        homeIDs: data['homeIDs'] != ''
            ? data['homeIDs'].entries.map((entry) => entry.key).toList()
            : [],
      );

  Map<String, dynamic> toJson() => {
        //! Don't push id to rtdb because key head contains user id
        // "id": id,
        "name": name,
        "email": email,
        "photoUrl": photoUrl,
        "homeIDs":
            homeIDs != null ? {for (var homeID in homeIDs!) homeID: true} : '',
      };
}
