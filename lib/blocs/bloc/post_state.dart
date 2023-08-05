part of 'post_bloc.dart';

enum PostStatus { intial, loading, success, failure }

class PostState extends Equatable {
  final PostStatus postStatus;
  final List<Post?> posts;
  final Failure failure;

  const PostState({
    required this.postStatus,
    required this.posts,
    required this.failure,
  });

  PostState copyWith({
    PostStatus? postStatus,
    List<Post?>? posts,
    Failure? failure,
  }) {
    return PostState(
      postStatus: postStatus ?? this.postStatus,
      posts: posts ?? this.posts,
      failure: failure ?? this.failure,
    );
  }

  factory PostState.inital() => const PostState(
        postStatus: PostStatus.intial,
        posts: [],
        failure: Failure(),
      );

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [postStatus, posts, failure];
}
