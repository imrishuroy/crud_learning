part of 'post_bloc.dart';

enum PostStatus { intial, loading, success, failure }

class PostState extends Equatable {
  final PostStatus postStatus;
  final List<Post?> posts;
  final Post? post;
  final Failure failure;

  const PostState({
    required this.postStatus,
    required this.posts,
    this.post,
    required this.failure,
  });

  PostState copyWith({
    PostStatus? postStatus,
    List<Post?>? posts,
    Post? post,
    Failure? failure,
  }) {
    return PostState(
      postStatus: postStatus ?? this.postStatus,
      posts: posts ?? this.posts,
      post: post ?? this.post,
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
  List<Object?> get props => [postStatus, posts, post, failure];
}
