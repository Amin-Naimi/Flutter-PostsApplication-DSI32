import 'package:app/core/exceptions/failures.dart';
import 'package:app/features/auth/domain/reposiotrys/user_repository.dart';
import 'package:dartz/dartz.dart';

class SignOutUserUseCase {
  final UserRepository userRepository;
  SignOutUserUseCase(this.userRepository);
  Future<Either<Failure, Unit>> call() async {
    return await userRepository.signOut();
  }
}
