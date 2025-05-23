import 'package:flutter/material.dart';
import 'package:task_11/data/models/post.dart';
import 'package:task_11/domain/post_repository.dart';
import 'package:task_11/presentation/comments_page.dart';

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
            return ListView.separated(
              itemCount: posts.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final post = posts[index];
                return Dismissible(
                  key: Key(post.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) async {
                    final success = widget.postRepository.deletePost(post.id);
                    if (await success) {
                      setState(() {
                        posts.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Post deleted')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Deleting error '),
                        ),
                      );
                      setState(() {});
                    }
                  },
                  child: ListTile(
                    title: Text(posts[index].title),
                    subtitle: Text(posts[index].body),
                    trailing: Text('User ID ${posts[index].userId}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CommentsPage(postId: posts[index].id),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("Not available"));
          }
        },
      ),
    );
  }
}
