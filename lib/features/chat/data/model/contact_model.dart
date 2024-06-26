import 'package:kizu/core/constant/constants.dart';
import 'package:kizu/features/chat/business/entity/contact_entity.dart';

class ContactModel extends ContactEntity {
  ContactModel({
    required super.uid,
    required super.displayName,
    super.statusMessage,
    super.contactID,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      uid: json[kUID] as String,
      displayName: json[kDisplayName] as String,
      statusMessage: json[kStatusMessage] as String?,
      contactID: json[kContactID] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kUID: uid,
      kDisplayName: displayName,
      kStatusMessage: statusMessage,
      kContactID: contactID,
    };
  }
}
