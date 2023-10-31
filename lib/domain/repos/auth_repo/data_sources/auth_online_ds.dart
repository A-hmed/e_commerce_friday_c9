import 'package:dartz/dartz.dart';

abstract class AuthOnlineDS {
  Future<Either<String, bool>> login(String email, String password);
}
