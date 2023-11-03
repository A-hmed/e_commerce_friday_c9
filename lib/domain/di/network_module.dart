import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class NetworkModule {
  Connectivity get connectivity => Connectivity();

  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
