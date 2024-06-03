import 'package:kizu/features/chat/business/entity/user_entity.dart';

class ContactEntity extends UserEntity {
  ContactEntity({
    required super.uid,
    required super.displayName,
    super.contactID,
    super.statusMessage,
  });
}
