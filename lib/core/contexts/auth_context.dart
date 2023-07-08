import 'package:flutter/material.dart';
import 'package:flutter_tutorial/core/models/meta_user.dart';

class AuthContext extends ChangeNotifier {
  MetaUser? _metaUser;

  MetaUser? get metaUser => _metaUser;

  void setMetaUser(MetaUser metaUser) {
    _metaUser = metaUser;
    notifyListeners();
  }

  void clearMetaUser() {
    _metaUser = null;
    notifyListeners();
  }

  void updateMetaUser(MetaUser metaUser) {
    _metaUser = metaUser;
    notifyListeners();
  }

  void updateMetaUserToken(String token) {
    _metaUser?.token = token;
    notifyListeners();
  }

  void updateMetaUserCreatedAt(String createdAt) {
    _metaUser?.createdAt = createdAt;
    notifyListeners();
  }

  void updateMetaUserUpdatedAt(String updatedAt) {
    _metaUser?.updatedAt = updatedAt;
    notifyListeners();
  }
}
