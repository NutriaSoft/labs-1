import 'package:flutter_tutorial/core/services/pocketbase_client.dart';
import 'package:flutter_tutorial/modules/chat/models/chat_response.dart';

void subscribeToMessage(String userId, notifyListeners, chats) {
  pbClient.collection("messages").subscribe(
    "*",
    (e) {
      final messageResponse =
          MessageResponse.fromMap(e.record!.toJson()).toMessage();

      if (!chats.containsKey(messageResponse.chat)) return;

      if (e.action == "delete") {
        chats[messageResponse.chat]!.messages.remove(messageResponse.id);
        notifyListeners();
      }

      if (e.action == "create" || e.action == "update") {
        chats[messageResponse.chat]!.messages[messageResponse.id] =
            messageResponse;
        notifyListeners();
      }
    },
  );
}
