// ignore: depend_on_referenced_packages
import 'package:uuid/uuid.dart';

class IDGenerator {
  static const uuid = Uuid();

  /// Generate ID based on time
  static String get timeBasedID => uuid.v1();
}
