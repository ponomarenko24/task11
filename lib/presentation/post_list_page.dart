import 'package:flutter/material.dart';
import 'package:task_11/data/models/post.dart';
import 'package:task_11/domain/post_repository.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key, required this.postRepository});

  final PostRepository postRepository;

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  late Future<List<Post>> posts;

  @override
  void initState() {
    super.initState();
    posts = widget.postRepository.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Post>>(
        future: posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(posts[index].title),
                  subtitle: Text(posts[index].body),
                  trailing: Text('User ID ${posts[index].userId}'),
                );
              },
            );
          } else {
          return Center(child: Text("Not available"));
          }
        } 
      ),
    );
  }
}
