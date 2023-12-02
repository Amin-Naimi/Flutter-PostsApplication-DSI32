import 'package:app/core/exceptions/failures.dart';
import 'package:app/core/strings/failures.dart';
import 'package:app/features/posts/domain/entities/post.dart';
import 'package:app/features/posts/domain/usecases/get_all_posts.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUsecase getAllPosts;

  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostsEvent) {
        emit(LoadingPostsState());

        final futurePosts =
            await getAllPosts(); //callable class getAllPosts().call()

        futurePosts.fold((failure) {
          emit(ErrorPostsState(message: _mapFailureToMessage(failure)));
        }, (posts) {
          emit(LoadedPostsState(posts: posts));
        });
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Erreur inconnue. Veuillez réessayer plus tard";
    }
  }
}
