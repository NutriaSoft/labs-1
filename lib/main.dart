import 'package:flutter/material.dart';
import 'package:flutter_tutorial/core/contexts/auth_context.dart';
import 'package:flutter_tutorial/core/theme/app_theme.dart';
import 'package:flutter_tutorial/modules/auth/views/login_screen.dart';
import 'package:flutter_tutorial/modules/auth/views/register_screen.dart';
import 'package:flutter_tutorial/modules/chat/contexts/list_chats_context.dart';
import 'package:flutter_tutorial/modules/chat/contexts/list_user_context.dart';
import 'package:flutter_tutorial/modules/chat/views/chat_screen.dart';
import 'package:flutter_tutorial/modules/chat/views/list_chats_screen.dart';
import 'package:flutter_tutorial/modules/chat/views/list_users_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter mainRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/list-chats',
        builder: (context, state) => const ListChatsScreen(),
      ),
      GoRoute(
        path: '/list-users',
        builder: (context, state) => const ListUsersScreen(),
      ),
      GoRoute(
        path: '/chat/:chatId',
        builder: (context, state) => ChatScreen(
          id: state.pathParameters['chatId']!,
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthContext(),
        ),
        ChangeNotifierProvider(
          create: (_) => ListChatsContext(),
        ),
        ChangeNotifierProvider(create: (_) => ListUsersContext())
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme(
          selectedTheme: 5,
          isDark: true,
        ).themeData,
        routerConfig: mainRouter,
      ),
    );
  }
}
