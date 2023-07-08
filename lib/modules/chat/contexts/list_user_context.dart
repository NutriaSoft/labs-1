import 'package:flutter/material.dart';
import 'package:flutter_tutorial/core/const/backurl.dart';
import 'package:flutter_tutorial/core/models/meta_user.dart';
import 'package:flutter_tutorial/core/services/pocketbase_client.dart';
import 'package:flutter_tutorial/modules/auth/models/user_response.dart';

class ListUsersContext extends ChangeNotifier {
  List<MetaUser> _listUsers = [];

  List<MetaUser> get listUsers => _listUsers;

  String tableName = "_pb_users_auth_";

  String? imageUrl({String? filename, required String id, String? thumb}) {
    print("archo: ${filename?.length}");
    if (filename == null || filename.isEmpty) return null;
    return "$backCDN/$tableName/$id/$filename${thumb != null ? "?thumb=$thumb" : ""}";
  }

  String userID = "";

  void setListUsers(String id) async {
    try {
      userID = id;
      final listUsersResponse =
          await pbClient.collection('users').getFullList(filter: "id != '$id'");

      final listUsers = listUsersResponse
          .map((e) => MetaUser(
                id: e.id,
                userData: UserResponse.fromMap(e.data).toUserData(),
                createdAt: e.created,
                updatedAt: e.updated,
              ))
          .toList();

      _listUsers = listUsers;

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
