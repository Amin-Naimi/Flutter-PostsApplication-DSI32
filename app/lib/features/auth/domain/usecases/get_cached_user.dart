import 'package:app/core/exceptions/failures.dart';
import 'package:app/features/auth/domain/entites/user_entity.dart';
import 'package:app/features/auth/domain/reposiotrys/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetCachedUserUseCase {
final UserRepository userRepository;
GetCachedUserUseCase(this.userRepository);
Future<UserEntity?> call() async {
return await userRepository.getCachedUser();
}
}
