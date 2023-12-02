import 'package:app/core/exceptions/failures.dart';
import 'package:app/features/auth/domain/entites/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
Future<Either<Failure, Unit>> signIn(UserEntity user);
Future<Either<Failure, Unit>> signOut();
Future<UserEntity?> getCachedUser();
}