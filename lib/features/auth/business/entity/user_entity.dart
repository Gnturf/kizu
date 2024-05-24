class UserEntity {
  final String uid;
  final String displayName;
  final String? statusMessage;
  final String email;
  final String? contactID;

  UserEntity({
    required this.uid,
    required this.displayName,
    this.statusMessage,
    required this.email,
    this.contactID,
  });
}
