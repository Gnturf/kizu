import 'package:kizu/core/constant/constants.dart';
import 'package:kizu/features/chat/business/entity/user_entity.dart';

class UserModel extends UserEntity {
  final String email;
  final String? password;

  UserModel({
    required super.uid,
    required super.displayName,
    super.statusMessage,
    required this.email,
    this.password,
    super.contactID,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json[kUID] as String,
      displayName: json[kDisplayName] as String,
      statusMessage: json[kStatusMessage] as String?,
      email: json[kEmail] as String,
      password: json[kPassword] as String?,
      contactID: json[kContactID] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kUID: uid,
      kDisplayName: displayName,
      kStatusMessage: statusMessage,
      kEmail: email,
      kPassword: password,
      kContactID: contactID,
    };
  }
}
