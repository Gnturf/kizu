class User {
  final String displayName;
  final String? statusMessage;
  final String? email;
  final String? password;
  final String? contactID;

  User({
    required this.displayName,
    this.statusMessage,
    required this.email,
    required this.password,
    this.contactID,
  });
}
