import 'dart:convert';

import 'package:flutter_tutorial/modules/chat/models/chat_model.dart';
import 'package:flutter_tutorial/modules/chat/models/message_model.dart';

class ChatResponse {
  final String? id;
  final DateTime? created;
  final DateTime? updated;
  final String? collectionId;
  final String? collectionName;
  final ChatExpand? expand;
  final String? icon;
  final String? name;
  final List<String>? users;

  ChatResponse({
    this.id,
    this.created,
    this.updated,
    this.collectionId,
    this.collectionName,
    this.expand,
    this.icon,
    this.name,
    this.users,
  });

  factory ChatResponse.fromJson(String str) =>
      ChatResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatResponse.fromMap(Map<String, dynamic> json) => ChatResponse(
        id: json["id"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        updated:
            json["updated"] == null ? null : DateTime.parse(json["updated"]),
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        expand:
            json["expand"] == null ? null : ChatExpand.fromMap(json["expand"]),
        icon: json["icon"],
        name: json["name"],
        users: json["users"] == null
            ? []
            : List<String>.from(json["users"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created": created?.toIso8601String(),
        "updated": updated?.toIso8601String(),
        "collectionId": collectionId,
        "collectionName": collectionName,
        "expand": expand?.toMap(),
        "icon": icon,
        "name": name,
        "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x)),
      };

  Chat toChat() => Chat(
        id: id!,
        created: created!,
        updated: updated!,
        messages: {for (final e in expand!.messagesChat!) e.id!: e.toMessage()},
        icon: icon,
        name: name!,
        users: users!,
      );
}

class ChatExpand {
  final List<MessageResponse>? messagesChat;

  ChatExpand({
    this.messagesChat,
  });

  factory ChatExpand.fromJson(String str) =>
      ChatExpand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatExpand.fromMap(Map<String, dynamic> json) => ChatExpand(
        messagesChat: json["messages(chat)"] == null
            ? []
            : List<MessageResponse>.from(
                json["messages(chat)"]!.map((x) => MessageResponse.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "messages(chat)": messagesChat == null
            ? []
            : List<dynamic>.from(messagesChat!.map((x) => x.toMap())),
      };
}

class MessageResponse {
  final String? id;
  final DateTime? created;
  final DateTime? updated;
  final String? collectionId;
  final String? collectionName;
  final String? body;
  final String? chat;
  final List<String>? files;
  final String? user;

  MessageResponse({
    this.id,
    this.created,
    this.updated,
    this.collectionId,
    this.collectionName,
    this.body,
    this.chat,
    this.files,
    this.user,
  });

  factory MessageResponse.fromJson(String str) =>
      MessageResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MessageResponse.fromMap(Map<String, dynamic> json) => MessageResponse(
        id: json["id"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        updated:
            json["updated"] == null ? null : DateTime.parse(json["updated"]),
        collectionId: json["collectionId"],
        collectionName: json["collectionName"],
        body: json["body"],
        chat: json["chat"],
        files: json["files"] == null
            ? []
            : List<String>.from(json["files"]!.map((x) => x)),
        user: json["user"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created": created?.toIso8601String(),
        "updated": updated?.toIso8601String(),
        "collectionId": collectionId,
        "collectionName": collectionName,
        "body": body,
        "chat": chat,
        "files": files == null ? [] : List<dynamic>.from(files!.map((x) => x)),
        "user": user,
      };

  Message toMessage() => Message(
        id: id!,
        created: created!,
        updated: updated!,
        body: body,
        files: files,
        user: user,
        chat: chat!,
      );
}
