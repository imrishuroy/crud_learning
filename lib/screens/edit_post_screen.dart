import 'package:crud_learning/blocs/bloc/post_bloc.dart';
import 'package:crud_learning/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPostScreen extends StatefulWidget {
  final Post? post;

  const EditPostScreen({super.key, required this.post});

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final _userIdController = TextEditingController();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  final _postBloc = PostBloc();

  @override
  void initState() {
    _userIdController.text = widget.post?.userId.toString() ?? '';
    _titleController.text = widget.post?.title ?? '';
    _bodyController.text = widget.post?.body ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit a Post'),
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
                        id: widget.post?.id,
                        userId: int.tryParse(_userIdController.text),
                        title: _titleController.text,
                        body: _bodyController.text,
                      );

                      _postBloc.add(
                        PostEdited(post: post),
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
