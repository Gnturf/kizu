import 'package:kizu/features/auth/business/entity/user_entity.dart';
import 'package:kizu/core/constant/constants.dart';

class UserModel extends UserEntity {
  final String uid;

  UserModel({
    required this.uid,
    required super.displayName,
    super.statusMessage,
    required super.email,
    super.contactID,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json[kUID] as String,
      displayName: json[kDisplayName] as String,
      statusMessage: json[kStatusMessage] as String?,
      email: json[kEmail] as String,
      contactID: json[kContactID] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kUID: uid,
      kDisplayName: displayName,
      kStatusMessage: statusMessage,
      kEmail: email,
      kContactID: contactID,
    };
  }
}
