import 'package:either_dart/either.dart';

abstract class AuthRepo {
  Future<Either<String, Map<String, dynamic>>> signUpUser({
    required String name,
    required String email,
    required String password,
    required String gender,
    required String birthdate,
  });
  Future<Either<String, Map<String, dynamic>>> verifyEmail({
    required String code
  });
}
