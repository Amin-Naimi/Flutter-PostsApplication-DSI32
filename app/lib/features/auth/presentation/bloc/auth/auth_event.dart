import 'package:app/features/auth/domain/entites/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final UserEntity user;
  LoginEvent({
    required this.user,
  });
  @override
  List<Object> get props => [user];
}

class LogOutEvent extends AuthEvent {}
