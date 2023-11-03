import 'dart:convert';

import 'package:e_commerce_friday_c9/data/model/api/response/auth_response.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class SharedPrefUtils {
  late SharedPreferences prefs;

  Future<void> saveToken(String token) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  void saveUser(User user) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("user", jsonEncode(user));
  }

  Future<String?> getToken() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  Future<User?> getUser() async {
    prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString("user");
    if (userString == null) return null;
    Map userJson = jsonDecode(userString);
    return User.fromJson(userJson);
  }
}
