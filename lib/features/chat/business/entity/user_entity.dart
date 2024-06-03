class UserEntity {
  final String uid;
  final String displayName;
  final String? statusMessage;
  final String? contactID;

  UserEntity({
    required this.uid,
    required this.displayName,
    this.statusMessage,
    this.contactID,
  });
}
