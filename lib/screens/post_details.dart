import 'package:crud_learning/blocs/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailsScreen extends StatefulWidget {
  final int postId;

  const PostDetailsScreen({super.key, required this.postId});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  final _postBloc = PostBloc();

  @override
  void initState() {
    _postBloc.add(PostFetchedById(postId: widget.postId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostBloc, PostState>(
        bloc: _postBloc,
        builder: (context, state) {
          if (state.postStatus == PostStatus.success) {
            final post = state.post;
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: ListTile(
                  title: Text(post?.title ?? 'N/A'),
                  subtitle: Text(post?.body ?? 'N/A'),
                  leading: CircleAvatar(
                    child: Text('${post?.id}'),
                  ),
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
