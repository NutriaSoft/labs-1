import 'package:flutter_tutorial/modules/chat/models/message_model.dart';

class Chat {
  final String id;
  final DateTime created;
  final DateTime updated;
  late final Map<String, Message> messages;
  final String? icon;
  final String name;
  final List<String> users;

  Chat({
    required this.id,
    required this.created,
    required this.updated,
    required this.messages,
    this.icon,
    required this.name,
    required this.users,
  });

  List<Message> get messagesList => messages.values.toList()
    ..sort((a, b) =>
        (a.created ?? DateTime.now()).compareTo(b.created ?? DateTime.now()));

  Message? get lastMessage =>
      messagesList.isNotEmpty ? messagesList.last : null;
}
