class Home {
  Home({
    required this.id,
    required this.name,
    required this.roomIDs,
  });

  final String id;
  final String name;
  final List<String>? roomIDs;

  factory Home.fromRTDB(Map<String, dynamic> data, String id) => Home(
        id: id,
        name: data['name'],
        roomIDs: data['roomIDs'] != ''
            ? [for (var ele in data['roomIDs'].entries) ele.key]
            : [],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "name": name,
        "roomIDs":
            roomIDs != null ? {for (var roomID in roomIDs!) roomID: true} : "",
      };
}
