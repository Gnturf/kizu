class User {
  final String id;
  final String displayName;
  final String statusMessage;
  final String username;
  final String password;
  final DateTime createdAt;
  final String email;
  final DateTime lastSeen;

  User({
    required this.id,
    required this.displayName,
    required this.statusMessage,
    required this.username,
    required this.password,
    required this.createdAt,
    required this.email,
    required this.lastSeen,
  });
}
