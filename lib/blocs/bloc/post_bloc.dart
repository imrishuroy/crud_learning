import 'package:crud_learning/models/failure.dart';
import 'package:crud_learning/models/post.dart';
import 'package:crud_learning/repositories/post_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository = PostRepository();

  PostBloc() : super(PostState.inital()) {
    on<PostLoaded>(
      (event, emit) async {
        try {
          emit(state.copyWith(postStatus: PostStatus.loading));

          final posts = await _postRepository.getPosts();
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
    on<PostFetchedById>(
      (event, emit) async {
        emit(state.copyWith(postStatus: PostStatus.loading));
        final post = await _postRepository.getPostById(event.postId);
        emit(
          state.copyWith(
            post: post,
            postStatus: PostStatus.success,
          ),
        );
      },
    );
    on<PostCreated>(
      (event, emit) async {
        emit(state.copyWith(postStatus: PostStatus.loading));
        final result = await _postRepository.createPost(post: event.post);
        emit(
          state.copyWith(
            postStatus: result ? PostStatus.success : PostStatus.failure,
          ),
        );
      },
    );
  }
}
