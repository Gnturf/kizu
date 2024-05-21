class UserEntity {
  final String displayName;
  final String? statusMessage;
  final String email;
  final String? contactID;

  UserEntity({
    required this.displayName,
    this.statusMessage,
    required this.email,
    this.contactID,
  });
}
