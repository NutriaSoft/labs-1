import 'package:flutter/material.dart';
import 'package:flutter_tutorial/core/contexts/auth_context.dart';
import 'package:flutter_tutorial/core/utils/get_theme.dart';
import 'package:flutter_tutorial/modules/chat/contexts/list_chats_context.dart';
import 'package:flutter_tutorial/modules/chat/contexts/list_user_context.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ListChatsScreen extends StatelessWidget {
  const ListChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ListUsersContext listUsersContext = Provider.of<ListUsersContext>(context);
    AuthContext authContext = Provider.of<AuthContext>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getTheme(context).secondaryContainer,
        title: const Text('List Chats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Aquí puedes manejar la acción de búsqueda
              print('Search button pressed');
            },
          ),
        ],
      ),
      body: Center(
        child: ListChats(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          listUsersContext.setListUsers(
            authContext.metaUser!.id,
          );
          context.go('/list-users');
        },
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..scale(-1.0, 1.0),
          child: const Icon(Icons.chat),
        ),
      ),
    );
  }
}

class ListChats extends StatefulWidget {
  ListChats({super.key});

  @override
  State<ListChats> createState() => _ListChatsState();
}

class _ListChatsState extends State<ListChats> {
  @override
  Widget build(BuildContext context) {
    ListChatsContext listChatsContext = Provider.of<ListChatsContext>(context);
    AuthContext authContext = Provider.of<AuthContext>(context);
    listChatsContext.initListChats(authContext.metaUser!.id);

    return ListView.builder(
      itemCount: listChatsContext.chatsList.length,
      itemBuilder: (context, index) {
        final chat = listChatsContext.chatsList[index];

        final imageUrl = listChatsContext.imageUrl(
            id: chat.id, filename: chat.icon, thumb: "100x100");

        return Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: ListTile(
            onTap: () {
              context.go('/chat/${chat.id}');
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                imageUrl ?? 'https://picsum.photos/200',
              ),
            ),
            title: Text('Chat ${chat.name}'),
            subtitle: Text(
              chat.lastMessage != null ? chat.lastMessage!.body! : "",
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }
}
