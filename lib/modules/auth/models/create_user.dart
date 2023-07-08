class CreateUser {
  String username;
  String email;
  String password;
  String confirmPassword;

  CreateUser({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  static CreateUser fromJson(Map<String, dynamic> json) {
    return CreateUser(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      confirmPassword: json['confirmPassword'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data["emailVisibility"] = false;
    data["name"] = null;
    data["desc"] = null;
    data['passwordConfirm'] = confirmPassword;
    return data;
  }


}
