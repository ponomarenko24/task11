import 'package:task_11/data/models/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
  Future<bool> deletePost(int postId);
}