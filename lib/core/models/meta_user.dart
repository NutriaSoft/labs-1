import 'package:flutter_tutorial/core/models/user_data.dart';

class MetaUser {
  String? token;
  String id;
  UserData userData;
  String createdAt;
  String updatedAt;

  MetaUser({
    this.token,
    required this.id,
    required this.userData,
    required this.createdAt,
    required this.updatedAt,
  });
}
