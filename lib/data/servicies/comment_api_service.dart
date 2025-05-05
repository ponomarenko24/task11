import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_11/data/models/comment.dart';

class CommentService {
  Future<List<Comment>> fetchComments(int postId) async {
    final url = 'https://jsonplaceholder.typicode.com/posts/$postId/comments';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Comment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}