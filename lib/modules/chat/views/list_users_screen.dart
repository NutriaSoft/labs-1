import 'package:flutter/material.dart';
import 'package:flutter_tutorial/core/contexts/auth_context.dart';
import 'package:flutter_tutorial/core/utils/get_theme.dart';
import 'package:flutter_tutorial/modules/chat/contexts/list_chats_context.dart';
import 'package:flutter_tutorial/modules/chat/contexts/list_user_context.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ListUsersScreen extends StatelessWidget {
  const ListUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getTheme(context).secondaryContainer,
        title: const Text('List users'),
        leading: Padding(
          padding: EdgeInsets.all(4.0),
          child: IconButton(
            onPressed: () => context.go("/list-chats"),
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Aquí puedes manejar la acción de búsqueda
              print('Search button pressed');
            },
          ),
        ],
      ),
      body: const Center(
        child: ListUsers(),
      ),
    );
  }
}

class ListUsers extends StatelessWidget {
  const ListUsers({super.key});

  @override
  Widget build(BuildContext context) {
    ListUsersContext listUsersContext = context.watch<ListUsersContext>();
    ListChatsContext listChatsContext = context.read<ListChatsContext>();
    return ListView.builder(
      itemCount: listUsersContext.listUsers.length,
      itemBuilder: (context, index) {
        final user = listUsersContext.listUsers[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 4.0),
          child: ListTile(
            onTap: () {
              (() async {
                final chatID = await listChatsContext.createChat(
                  name: "New chat ${index + 1}",
                  users: [user.id],
                );
                context.go("/chat/$chatID");
              })();
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                listUsersContext.imageUrl(
                      id: user.id,
                      filename: user.userData.avatar,
                      thumb: "100x100",
                    ) ??
                    "https://static.vecteezy.com/system/resources/previews/000/574/512/original/vector-sign-of-user-icon.jpg",
              ),
            ),
            title: Text(user.userData.name ?? "No name user"),
            subtitle: Text(
              user.userData.description ?? "",
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }
}
