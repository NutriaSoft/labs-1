import 'package:flutter_tutorial/core/services/pocketbase_client.dart';
import 'package:flutter_tutorial/modules/chat/models/chat_response.dart';

void subscribeToChats(String userId, notifyListeners, chats) {
  pbClient.collection("chats").subscribe(
    "*",
    (e) {
      final chatResponse = ChatResponse.fromMap(e.record!.toJson()).toChat();

      if (!chatResponse.users.contains(userId)) return;

      if (e.action == "delete") {
        chats.remove(chatResponse.id);
        notifyListeners();
      }

      if (e.action == "create" || e.action == "update") {
        final oldChat = chats[chatResponse.id];
        if (oldChat != null) chatResponse.messages = oldChat.messages;

        chats[chatResponse.id] = chatResponse;
        notifyListeners();
      }
    },
  );
}
