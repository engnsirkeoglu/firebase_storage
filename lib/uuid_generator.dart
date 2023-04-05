import 'package:uuid/uuid.dart';

class UuidGenerator {
  final Uuid _uuid = const Uuid();
  // Random identifier generator
  String generateV4() {
    return _uuid.v4();
  }
}
