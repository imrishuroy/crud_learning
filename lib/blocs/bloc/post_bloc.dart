import 'package:crud_learning/repositories/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crud_learning/models/failure.dart';
import 'package:crud_learning/models/post.dart';
import 'package:equatable/equatable.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostState.inital()) {
    on<PostLoaded>(
      (event, emit) async {
        try {
          emit(state.copyWith(postStatus: PostStatus.loading));
          final postRepository = PostRepository();

          final posts = await postRepository.getPosts();
          emit(
            state.copyWith(
              posts: posts,
              postStatus: PostStatus.success,
            ),
          );
        } on Failure catch (failure) {
          emit(
            state.copyWith(
              failure: failure,
              postStatus: PostStatus.failure,
            ),
          );
        }
      },
    );
  }
}
