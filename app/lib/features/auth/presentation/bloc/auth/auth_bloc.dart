import 'package:app/core/exceptions/failures.dart';
import 'package:app/core/strings/failures.dart';
import 'package:app/features/auth/domain/usecases/sign_in_user.dart';
import 'package:app/features/auth/domain/usecases/sign_out_user.dart';
import 'package:app/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:app/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUserUseCase signInUserUseCase;
  final SignOutUserUseCase signOutUserUseCase;
  AuthBloc({required this.signInUserUseCase, required this.signOutUserUseCase})
      : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginProgressState());
        final failedOrDoneLogin = await signInUserUseCase(event.user);
        failedOrDoneLogin.fold((left) {
          emit(AuthErrorState(message: _mapLoginFailureToMessage(left)));
          emit(UnAuthenticatedState());
//envoyer plusieurs états
//c pas une regle le fait d'envoyer un seul etat par event
        }, (right) {
          emit(AuthenticatedState(message: "authenticated"));
        });
      } else if (event is LogOutEvent) {
        emit(LogOutInProgressState());
        final failedOrDoneLogOut = await signOutUserUseCase();
        failedOrDoneLogOut.fold((left) {
          emit(AuthErrorState(message: _mapLogOutFailureToMessage(left)));
          emit(AuthenticatedState(message: "authenticated"));
        }, (right) => emit(UnAuthenticatedState()));
      }
    });
  }
  String _mapLoginFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Erreur inconnue...";
    }
  }

  String _mapLogOutFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Erreur inconnue...";
    }
  }
}
