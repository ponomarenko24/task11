import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_11/data/repositories/post_repository_impl.dart';
import 'package:task_11/data/servicies/post_api_service.dart';
import 'package:task_11/domain/post_repository.dart';
import 'package:task_11/presentation/post_list_page.dart';

void main() {
final client = http.Client();
final remoteDataSource = PostApiService(client);
final repository = PostRepositoryImpl(remoteDataSource);

  runApp( MainApp(postRepository: repository,));
}

class MainApp extends StatelessWidget {
  final PostRepository postRepository;
  const MainApp({super.key, required this.postRepository});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PostListPage(postRepository: postRepository,),
    );
  }
}
