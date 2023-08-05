import 'package:crud_learning/blocs/bloc/post_bloc.dart';
import 'package:crud_learning/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _userIdController = TextEditingController();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  final _postBloc = PostBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Post'),
        centerTitle: true,
      ),
      body: BlocConsumer<PostBloc, PostState>(
        bloc: _postBloc,
        listener: (context, state) {
          if (state.postStatus == PostStatus.success) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state.postStatus == PostStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _userIdController,
                    decoration: const InputDecoration(
                      hintText: 'Enter User Id',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _bodyController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Body',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  ElevatedButton(
                    onPressed: () {
                      Post post = Post(
                        userId: int.tryParse(_userIdController.text),
                        title: _titleController.text,
                        body: _bodyController.text,
                      );

                      _postBloc.add(
                        PostCreated(post: post),
                      );
                    },
                    child: const Text('Submit'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
