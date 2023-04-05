import 'package:uuid/uuid.dart';

mixin RandomImageNameGenerator {
  final Uuid _uuid = const Uuid();
  String? getRandomImageName() {
    return '${_uuid.v4()}.png';
  }
}
