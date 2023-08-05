import 'package:crud_learning/blocs/bloc/post_bloc.dart';
import 'package:crud_learning/screens/create_post_screen.dart';
import 'package:crud_learning/screens/edit_post_screen.dart';
import 'package:crud_learning/screens/post_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final _postBloc = PostBloc();

  @override
  void initState() {
    _postBloc.add(PostLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts Screen'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const CreatePostScreen(),
              ),
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<PostBloc, PostState>(
        bloc: _postBloc,
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
                        return Dismissible(
                          key: Key(posts[index].toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(color: Colors.red.shade700),
                          onDismissed: (direction) {
                            if (post?.id != null) {
                              _postBloc.add(PostDeleted(id: post!.id!));
                            }
                          },
                          child: GestureDetector(
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
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 20.0,
                                  ),
                                  onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => EditPostScreen(
                                        post: post,
                                      ),
                                    ),
                                  ),
                                ),
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
