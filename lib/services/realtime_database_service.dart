import 'package:firebase_database/firebase_database.dart';

/// This class define the return result of some method of the RealtimeDatabaseService
class DatabaseResult {
  final bool success;
  final String response;

  DatabaseResult({required this.success, this.response = ''});

  factory DatabaseResult.success({response}) =>
      DatabaseResult(success: true, response: response);

  factory DatabaseResult.failure(String errorResponse) =>
      DatabaseResult(success: false, response: errorResponse);
}

class DatabasePath {
  static String user(String userId) => 'users/$userId';

  static String home(String userId, String homeId) =>
      'users/$userId/homes/$homeId';

  static String room(String userId, String homeId, String roomId) =>
      'users/$userId/homes/$homeId/rooms/$roomId';

  static String device(
          String userId, String homeId, String roomId, String deviceId) =>
      'users/$userId/homes/$homeId/rooms/$roomId/devices/$deviceId';
}

class RealtimeDatabaseService {
  RealtimeDatabaseService._();

  static final _databaseRef = FirebaseDatabase.instance.ref();

  static DatabaseReference get databaseRef => _databaseRef;

  static Future<void> createData(String path, dynamic value) async {}

  static Future<void> updateData(String path, dynamic value) async {
    try {
      await _databaseRef.child(path).update(value);
    } catch (e) {}
  }

  static Future<Map> readData(String path) async {
    try {
      DatabaseEvent event = await _databaseRef.child(path).once();

      final Map result = event.snapshot.value as Map;

      return result;
    } catch (e) {
      return {'Error': ''};
    }
  }

  static Future<DatabaseResult> deleteData(String path) async {
    try {
      await _databaseRef.child(path).remove();

      return DatabaseResult.success();
    } catch (e) {
      return DatabaseResult.failure(e.toString());
    }
  }
}
