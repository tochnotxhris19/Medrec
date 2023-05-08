import 'dart:convert';

import '../../models/auth_user.dart';
import 'shared_service.dart';

class AuthService {
  AuthUser? authUser;

  static AuthService instance = AuthService();

  login(Map<String, dynamic> userMap) async {
    authUser = AuthUser.fromJson(userMap);

    await setPreference('authUser', jsonEncode(authUser));
  }

  Future load() async {
    String? userString = await getPreference('authUser');
    if (userString == null) {
      return false;
    }
    authUser = AuthUser.fromJson(jsonDecode(userString));

    return true;
  }

  Future logout() async {
    return await removePreference('authUser');
  }
}
