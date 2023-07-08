import 'package:flutter/material.dart';
import 'package:flutter_tutorial/core/contexts/auth_context.dart';
import 'package:flutter_tutorial/modules/chat/contexts/list_chats_context.dart';
import 'package:flutter_tutorial/modules/chat/models/chat_model.dart';
import 'package:flutter_tutorial/modules/chat/models/message_model_old.dart';
import 'package:flutter_tutorial/modules/chat/views/list_chats_screen.dart';
import 'package:flutter_tutorial/modules/chat/widgets/down_button.dart';

import 'package:flutter_tutorial/modules/chat/widgets/bubble_message.dart';
import 'package:flutter_tutorial/modules/chat/widgets/message_field.dart';
import 'package:flutter_tutorial/core/utils/get_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  final String id;

  const ChatScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final ListChatsContext chatList = context.watch<ListChatsContext>();
    final Chat chat = chatList.chats[id]!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getTheme(context).secondaryContainer,
        leading: Padding(
          padding: EdgeInsets.all(4.0),
          child: IconButton(
            onPressed: () => context.go("/list-chats"),
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              chatList.imageUrl(
                    id: chat.id,
                    filename: chat.icon,
                    thumb: "100x100"
                  ) ??
                  'https://media.discordapp.net/attachments/1085036962198601789/1120483053890961528/image.png',
            ),
          ),
        ],
        centerTitle: true,
        title: Text(chat.name),
      ),
      body: ChatView(
        chat: chat,
      ),
    );
  }
}

class ChatView extends StatelessWidget {
  final Chat chat;
  const ChatView({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = getTheme(context);
    final ScrollController scrollController = ScrollController();

    final AuthContext auth = context.watch<AuthContext>();
    final ListChatsContext chatList = context.watch<ListChatsContext>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ListView.builder(
                    itemCount: chat.messagesList.length,
                    reverse: true,
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      final message = chat
                          .messagesList[chat.messagesList.length - index - 1];

                      final typeMessage = auth.metaUser!.id != message.user;

                      return BubbleMessage(
                        colorBubble: typeMessage
                            ? colors.primaryContainer
                            : colors.inversePrimary,
                        colorText: typeMessage
                            ? colors.inverseSurface
                            : colors.onSurface,
                        left: typeMessage,
                        text: message.body,
                        image: null,
                      );
                    },
                  ),
                  DownButton(
                      colors: colors, scrollController: scrollController),
                ],
              ),
            ),
            MessageFieldBox(
              onValue: (value) {
                chatList.sendMessage(chat.id, value);
                scrollController.animateTo(
                  0.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
