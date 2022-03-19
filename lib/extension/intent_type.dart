import 'package:home_screen_codes/domain/entity/codes.dart';

extension IntentTypeX on IntentType {
  static IntentType fromString(String value) {
    switch (value) {
      case 'next':
        return IntentType.next;
      case 'previous':
        return IntentType.previous;
      default:
        return throw Exception('Unknown IntentType: $value');
    }
  }
}
