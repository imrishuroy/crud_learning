import 'package:crud_learning/blocs/bloc/post_bloc.dart';
import 'package:crud_learning/screens/post_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostBloc, PostState>(
        bloc: PostBloc()..add(PostLoaded()),
        builder: (context, state) {
          if (state.postStatus == PostStatus.success) {
            final posts = state.posts;

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return GestureDetector(
                          onTap: () {
                            if (post?.id != null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => PostDetailsScreen(
                                    postId: post!.id!,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                            ),
                            child: ListTile(
                              title: Text(post?.title ?? 'N/A'),
                              //  subtitle: Text(post?.body ?? 'N/A'),
                              leading: CircleAvatar(
                                child: Text('${post?.id}'),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                    ),
                  ),
                ],
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
