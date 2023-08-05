import 'package:crud_learning/models/failure.dart';
import 'package:crud_learning/models/post.dart';
import 'package:dio/dio.dart';

class PostRepository {
  Future<List<Post?>> getPosts() async {
    try {
      List<Post?> posts = [];

      final dio = Dio();

      final response =
          await dio.get('https://jsonplaceholder.typicode.com/posts');

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
}
