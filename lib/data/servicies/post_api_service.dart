import 'dart:convert';
import 'package:http/http.dart';
import 'package:task_11/data/models/post.dart';

class PostApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  final Client client;
  const PostApiService(this.client);

  Future<List<Post>> fetchPosts() async {
    final response = await client.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}