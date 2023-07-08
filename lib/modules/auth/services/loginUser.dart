import 'package:flutter/material.dart';
import 'package:flutter_tutorial/core/models/meta_user.dart';
import 'package:flutter_tutorial/core/services/pocketbase_client.dart';
import 'package:flutter_tutorial/modules/auth/models/user_response.dart';

Future<MetaUser?> loginUser(String usernameOrEmail, String password,
    ValueNotifier<String?> notifier) async {
  final pbClient = getPBClient();

  try {
    final response = await pbClient
        .collection("users")
        .authWithPassword(usernameOrEmail, password);

    final userResponse = UserResponse.fromMap(response.record!.data);

    final metaUser = MetaUser(
      token: response.token,
      id: response.record!.id,
      userData: userResponse.toUserData(),
      createdAt: response.record!.created,
      updatedAt: response.record!.updated,
    );

    return metaUser;
  } catch (e) {
    notifier.value = 'Invalid username or password. Please try again.';
    return null;
  }
}
