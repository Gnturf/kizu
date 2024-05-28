class ContactEntity {
  final String uid;
  final String displayName;
  final String? statusMessage;
  final String? contactID;

  ContactEntity({
    required this.uid,
    required this.displayName,
    this.statusMessage,
    this.contactID,
  });
}
