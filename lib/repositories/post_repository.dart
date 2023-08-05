import 'package:crud_learning/models/failure.dart';
import 'package:crud_learning/models/post.dart';
import 'package:dio/dio.dart';

class PostRepository {
  final _dio = Dio();

  Future<List<Post?>> getPosts() async {
    try {
      List<Post?> posts = [];
      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/posts');

      // print('response data ${response.data.runtimeType}');

      final data = response.data as List<dynamic>;

      for (var element in data) {
        final post = Post.fromMap(element);
        posts.add(post);
      }

      return posts;
    } on DioException catch (error) {
      print('Dio Error ${error.message}');
      throw Failure(
        statusCode: error.response?.statusCode,
        statusMessage: error.message,
      );
    }
  }

  Future<Post?> getPostById(int id) async {
    try {
      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/posts/$id');

      if (response.statusCode == 200) {
        return Post.fromMap(response.data);
      }
      return null;
    } on DioException catch (error) {
      print('Dio Error ${error.message}');
      throw Failure(
        statusCode: error.response?.statusCode,
        statusMessage: error.message,
      );
    }
  }

  Future<bool> createPost({
    required Post post,
  }) async {
    try {
      final response = await _dio.post(
        'https://jsonplaceholder.typicode.com/posts',
        data: post.toMap(),
      );

      print('create post response $response');

      return response.statusCode == 201;
    } on DioException catch (error) {
      print('Dio Error ${error.message}');
      throw Failure(
        statusCode: error.response?.statusCode,
        statusMessage: error.message,
      );
    }
  }

  Future<bool> editPost({
    required Post post,
  }) async {
    try {
      final response = await _dio.put(
        'https://jsonplaceholder.typicode.com/posts/${post.id}',
        data: post.toMap()..addAll({'id': post.id}),
      );

      print('create post response $response');

      return response.statusCode == 200;
    } on DioException catch (error) {
      print('Dio Error ${error.message}');
      throw Failure(
        statusCode: error.response?.statusCode,
        statusMessage: error.message,
      );
    }
  }
}
