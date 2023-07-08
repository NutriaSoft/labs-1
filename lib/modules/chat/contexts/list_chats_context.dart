import 'package:flutter/material.dart';
import 'package:flutter_tutorial/core/const/backurl.dart';
import 'package:flutter_tutorial/core/services/pocketbase_client.dart';
import 'package:flutter_tutorial/modules/chat/models/chat_model.dart';
import 'package:flutter_tutorial/modules/chat/models/chat_response.dart';
import 'package:flutter_tutorial/modules/chat/services/subscribe_chats.dart';
import 'package:flutter_tutorial/modules/chat/services/subscribe_message.dart';

class ListChatsContext extends ChangeNotifier {
  final Map<String, Chat> _chats = {};

  String? userId;

  String tableName = "i2ew7ir0e5a51qc";

  Map<String, Chat> get chats => _chats;

  List<Chat> get chatsList => _chats.values.toList();

  String? imageUrl({String? filename, required String id, String? thumb}) {
    print("archo: ${filename?.length}");
    if (filename == null || filename.isEmpty) return null;
    return "$backCDN/$tableName/$id/$filename${thumb != null ? "?thumb=$thumb" : ""}";
  }

  void initListChats(String id) async {
    if (_chats.isNotEmpty) return;
    userId = id;
    final data = await pbClient.collection("chats").getList(
          filter: "users ?~ '$id'",
          expand: "messages(chat)",
        );

    tableName = data.items[0].collectionId;

    for (final item in data.items) {
      final chatResponse = ChatResponse.fromMap(item.toJson()).toChat();
      _chats[chatResponse.id] = chatResponse;
    }
    toSuscribe();

    notifyListeners();
  }

  void toSuscribe() {
    subscribeToMessage(
      userId!,
      notifyListeners,
      _chats,
    );

    subscribeToChats(
      userId!,
      notifyListeners,
      _chats,
    );
  }

  Future<String> createChat(
      {required String name, String? icon, required List<String> users}) async {
    final chat = ChatResponse(
      name: name,
      icon: icon,
      users: users + [userId!],
    );

    final data = await pbClient.collection("chats").create(body: chat.toMap());

    final chatCreated = ChatResponse.fromMap(data.toJson()).toChat();

    _chats[chatCreated.id] = chatCreated;

    notifyListeners();

    return chatCreated.id;
  }

  void updateChat(String id, String name, String? icon) async {
    final chat = ChatResponse(
      name: name,
      icon: icon,
    );

    final data = await pbClient
        .collection("chats")
        .update(id, body: chat.toMap(), expand: "messages(chat)");

    final chatUpdated = ChatResponse.fromMap(data.toJson()).toChat();

    _chats[chatUpdated.id] = chatUpdated;

    notifyListeners();
  }

  void deleteChat(String id) async {
    await pbClient.collection("chats").delete(id);

    _chats.remove(id);

    notifyListeners();
  }

  void sendMessage(String chatId, String text) async {
    final message = MessageResponse(
      body: text,
      chat: chatId,
      user: userId!,
    );

    final data =
        await pbClient.collection("messages").create(body: message.toMap());

    final messageResponse = MessageResponse.fromMap(data.toJson()).toMessage();

    _chats[message.chat]?.messages[messageResponse.id!] = messageResponse;
    notifyListeners();
  }
}
