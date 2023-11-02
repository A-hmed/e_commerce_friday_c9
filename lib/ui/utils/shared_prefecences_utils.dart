import 'dart:convert';

import 'package:e_commerce_friday_c9/data/model/response/auth_response.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class SharedPrefUtils {
  saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", jsonEncode(user.toJson()));
  }

  Future<User?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userAsString = prefs.getString("user");
    if (userAsString == null) return null;
    return User.fromJson(jsonDecode(userAsString));
  }

  saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }
}
