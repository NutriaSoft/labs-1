import 'package:flutter_tutorial/core/models/meta_user.dart';
import 'package:flutter_tutorial/core/services/pocketbase_client.dart';
import 'package:flutter_tutorial/modules/auth/models/create_user.dart';
import 'package:pocketbase/pocketbase.dart';

import 'loginUser.dart';

Future<MetaUser?> createUserService(CreateUser user, Function data) async {
  try {
    final pbClient = getPBClient();

    await pbClient.collection("users").create(
          body: user.toJson(),
        );
/*     pbClient.collection("users").requestVerification(
          user.email,
        ); */

    final metaUser = await loginUser(
      usernameOrEmail: user.email,
      password: user.password,
    );

    return metaUser;
  } catch (e) {
    data(e);
    return null;
  }
}
