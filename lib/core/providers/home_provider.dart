import 'package:do_an_1_iot/core/models/home.dart';
import 'package:do_an_1_iot/core/providers/user_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider with ChangeNotifier {
  List<Home>? homeList = [];
  final homeIDList = UserProvider.homeIDList;
  final _realTimeDBRef = FirebaseDatabase.instance.ref();

  static const HOME_PATH = 'homes';

  List<Home>? get getHomeList => homeList;

  Future<void> fetchHomeData() async {
    // TODO: Get homeIDList without passing
    // Reset home list and home IDList when fetch
    final homeIDList = UserProvider.homeIDList;
    homeList = [];
    if (homeIDList != null) {
      for (var homeID in homeIDList) {
        final snapshot =
            await _realTimeDBRef.child(HOME_PATH).child(homeID).get();
        if (snapshot.exists) {
          var home = Home.fromRTDB(
              Map<String, dynamic>.from(
                  snapshot.value as Map<dynamic, dynamic>),
              homeID);

          homeList?.add(home);
        }
      }
    }
    notifyListeners();
  }
}
