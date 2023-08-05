part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class PostLoaded extends PostEvent {}

class PostFetchedById extends PostEvent {
  final int postId;

  const PostFetchedById({required this.postId});

  @override
  List<Object> get props => [postId];
}

class PostCreated extends PostEvent {
  final Post post;

  const PostCreated({required this.post});

  @override
  List<Object> get props => [post];
}

class PostEdited extends PostEvent {
  final Post post;

  const PostEdited({required this.post});

  @override
  List<Object> get props => [post];
}

class PostDeleted extends PostEvent {
  final int id;
  const PostDeleted({required this.id});

  @override
  List<Object> get props => [id];
}
