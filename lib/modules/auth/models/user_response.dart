import 'dart:convert';

import 'package:flutter_tutorial/core/models/user_data.dart';

class UserResponse {
  final String? avatar;
  final String? email;
  final bool? emailVisibility;
  final String? name;
  final String? username;
  final bool? verified;
  final String? description;

  UserResponse({
    this.avatar,
    this.email,
    this.emailVisibility,
    this.name,
    this.username,
    this.verified,
    this.description,
  });

  factory UserResponse.fromJson(String str) =>
      UserResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
        avatar: json["avatar"],
        email: json["email"],
        emailVisibility: json["emailVisibility"],
        name: json["name"],
        username: json["username"],
        verified: json["verified"],
        description: json["desc"],
      );

  Map<String, dynamic> toMap() => {
        "avatar": avatar,
        "email": email,
        "emailVisibility": emailVisibility,
        "name": name,
        "username": username,
        "verified": verified,
        "desc": description,
      };

  UserData toUserData() => UserData(
        avatar: avatar,
        email: email,
        emailVisibility: emailVisibility,
        name: name,
        username: username,
        verified: verified,
        description: description,
      );
}
