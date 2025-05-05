import 'package:task_11/data/models/post.dart';
import 'package:task_11/data/servicies/post_api_service.dart';
import 'package:task_11/domain/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostApiService remoteDataSource;

  const PostRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Post>> getPosts() async {
    return await remoteDataSource.fetchPosts();
  }
}