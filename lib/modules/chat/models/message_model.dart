class Message {
  final String? id;
  final DateTime? created;
  final DateTime? updated;
  final String? body;
  final List<String>? files;
  final String? user;
  final String chat;

  Message({
    required this.id,
    required this.created,
    required this.updated,
    this.body,
    this.files,
    this.user,
    required this.chat,
  });
}
