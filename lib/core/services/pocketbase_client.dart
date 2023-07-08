import 'package:flutter_tutorial/core/const/backurl.dart';
import 'package:pocketbase/pocketbase.dart';


final pbClient = PocketBase(backURL);

PocketBase getPBClient() {
  return pbClient;
}
