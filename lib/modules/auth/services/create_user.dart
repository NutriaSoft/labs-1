import 'package:flutter_tutorial/core/services/pocketbase_client.dart';
import 'package:flutter_tutorial/modules/auth/models/create_user.dart';
import 'package:pocketbase/pocketbase.dart';

Future<RecordModel?> createUserService(CreateUser user, Function data) async {
  try {
    final pbClient = getPBClient();

    final response = await pbClient.collection("users").create(
          body: user.toJson(),
        );

    pbClient.collection("users").requestVerification(
          user.email,
        );

    return response;
  } catch (e) {
    data(e);
    return null;
  }
}
