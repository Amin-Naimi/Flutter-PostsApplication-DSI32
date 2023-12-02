import 'package:app/core/exceptions/failures.dart';
import 'package:app/features/auth/domain/reposiotrys/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../entites/user_entity.dart';

class SignInUserUseCase {
  final UserRepository userRepository;

  //injecter par SL
  SignInUserUseCase(this.userRepository);
  Future<Either<Failure, Unit>> call(UserEntity user) async {
    return await userRepository.signIn(user);
  }
}
